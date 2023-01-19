class Parser

  def initialize(file_path)
    @file_path = file_path
    @games = [] #Usar hash?
  end
  
  def parse_games
    current_game = [] 
    File.foreach(@file_path) do |line| 
      if line.include? "InitGame:" 
        if current_game 
          @games.push(current_game)
        end
      elsif line.include? "Kill:"
        current_game.push(line)
      end
    end
    @games.push(current_game) unless current_game.empty?
  end

  def parse_players
    @games.each_with_index do |game_line, index|
      players = {}
      player_names = []
      total_kills = 0
      game_line.each do |line|
        killer_match = line.match(/^.*:\s+(.*)\skilled/)
        killer = killer_match[1]
        victim_match = line.match(/killed\s+(.*)\sby/)
        victim = victim_match[1]
        players[killer] = {"Kills" => 0, "Deaths" => 0} unless players[killer]
        players[victim] = {"Kills" => 0, "Deaths" => 0} unless players[victim]
        if killer == "<world>"
          players[victim]["Kills"] -= 1
          players[victim]["Deaths"] += 1
          total_kills += 1
        else
          if killer == victim
            players[victim]["Deaths"] += 1
            players[victim]["Kills"] -= 1
            total_kills += 1
          else
            players[killer]["Kills"] +=1
            players[victim]["Deaths"] +=1
            total_kills += 1
            player_names.push(killer) unless player_names.include?(killer)
          end
        end
        player_names.push(victim) unless player_names.include?(victim)
        players.delete("<world>")
        player_names.delete("<world>")
      end
      @games[@games.index(game_line)] = { "Game" => index+1, "Total kills:" => total_kills, "Players:" => player_names, "Kills:" => players}
    end
  end
end