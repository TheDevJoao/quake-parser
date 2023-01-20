require_relative 'game'
require_relative 'player'

class Parser
  def initialize(file_path)
    @file_path = file_path
    @file_content = open_file(@file_path)
  end

  def parse
    games = []
    current_game = nil
    players = {}

    @file_content.each do |line| 
      if start_game?(line)
        current_game = new_game(games)
        players = {}
      elsif kill_line?(line)
        killer, victim = killer_victim(line)
        players[killer] = players[killer] || Player.new(killer)
        players[victim] = players[victim] || Player.new(victim)

        if killer == "<world>"
          players[victim].lose_kill
          players[victim].add_death
          current_game.add_kill
        else
          players[killer].add_kill
          players[victim].add_death
          players[killer].who_killed_who(players[victim].name)
          current_game.add_kill
          current_game.add_player(players[killer])
        end
      end
    end
    games.each {|game| puts game.show_game }
  end

  private

  def new_game(games)
    current_game = Game.new(games.size + 1)
    games << current_game
    current_game
  end

  def start_game?(str)
    str.include? "InitGame:"
  end

  def kill_line?(str)
    str.include? "Kill:"
  end

  def killer_victim(str)
    killer_match = str.match(/^.*:\s+(.*)\skilled/)
    victim_match = str.match(/killed\s+(.*)\sby/)
    [killer_match[1], victim_match[1]]
  end
  
  def open_file(file)
    File.readlines(file, chomp: true)
  end
end