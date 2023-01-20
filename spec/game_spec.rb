require 'parser'
require 'game'
require 'player'

describe Game do
  let(:game) { Game.new(1) }
  let(:player1) { double('player1', name: 'Player1', kills: 3) }
  let(:player2) { double('player2', name: 'Player2', kills: 2) }

  describe '#add_player' do
    it 'adds a player to the game' do
      game.add_player(player1)
      expect(game.players).to have_key('Player1')
    end
  end

  describe '#players_name' do
    it 'returns an array of the players names' do
      game.add_player(player1)
      game.add_player(player2)
      expect(game.players_name).to eq(['Player1', 'Player2'])
    end
  end

  describe '#add_kill' do
    it 'increases the total kills by 1' do
      game.add_kill
      expect(game.total_kills).to eq(1)
    end
  end

  describe '#format_kills' do
    it 'returns a formatted string of the players kills' do
      game.add_player(player1)
      game.add_player(player2)
      expect(game.format_kills).to eq("    Player1: 3,\n    Player2: 2")
    end
  end

  describe '#show_game' do
    it 'returns a formatted string of the each game' do
      game.add_player(player1)
      game.add_player(player2)
      game.add_kill
      expect(game.show_game).to eq("Game: 1 {\n Total Kills: 1\n Players: Player1, Player2\n Kills: \n    Player1: 3,\n    Player2: 2\n}\n")
    end
  end

  describe '#print_report' do
    it 'prints the leaderboard of the game' do
      game.add_player(player1)
      game.add_player(player2)
      expect { game.print_report }.to output("Game 1 Leaderboard:\nPlayer1 - 3 kills\nPlayer2 - 2 kills\n").to_stdout
    end
  end
end