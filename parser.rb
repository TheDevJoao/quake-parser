class Parser
  
  def initialize(file_path)
    @file_path = file_path
    @games = []
  end
  
  def parse_games
    current_game = [] 
    File.foreach(@file_path) do |line| 
      if line.include? "InitGame" 
        if current_game 
          @games.push(current_game)
        end
        current_game = []
      elsif line.include? "Kill"
        current_game.push(line)
      end
    end
    @games.push(current_game) unless current_game.empty?
  end

  def parse_players
    @games.each_with_index do |game_line, index|
      players = {}
      total_kills = 0
      player_names = []
      game_line.each do |line|
        split = line.split
        killer = split[5]
        victim = split[7]
        if killer == "<world>" || killer == killer
          players[victim] = {"kills" => 0, "deaths" => 0} unless players[victim]
          players[victim]["deaths"] += 1
          total_kills -= 1
          player_names.push(victim) unless player_names.include?(victim)
        else
          players[killer] = {"kills" => 0, "deaths" => 0} unless players[killer]
          players[victim] = {"kills" => 0, "deaths" => 0} unless players[victim]
          players[killer]["kills"] += 1
          players[victim]["deaths"] += 1
          total_kills += 1
          player_names.push(killer) unless player_names.include?(killer)
          player_names.push(victim) unless player_names.include?(victim)
        end
      end
      @games[@games.index(game_line)] = { "Game" => index+1, "total_kills:" => total_kills, "players:" => player_names, "kills:" => players}
    end
  end
end