class Game
  attr_reader :game_number
  attr_accessor :players, :total_kills

  def initialize(game_number)
    @game_number = game_number
    @players = {}
    @total_kills = 0
  end

  def add_player(player)
    @players[player.name] = player
  end

  def players_name
    @players.keys
  end

  def add_kill
    @total_kills += 1
  end

  def format_kills
    @players.map { |name, player| "    #{name}: #{player.kills}" }.join(",\n")
  end

  def show_game
    "Game: #{@game_number} {\n" +
    " Total Kills: #{@total_kills}\n" +
    " Players: #{players_name.join(', ')}\n" +
    " Kills: \n#{format_kills}\n" +
    "}\n"
  end
end