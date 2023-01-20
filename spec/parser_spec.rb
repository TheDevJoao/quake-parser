require 'parser'
require 'game'
require 'player'

describe Parser do
  let(:file_path) { 'games.log' }
  let(:parser) { Parser.new(file_path) }
  subject { parser }
  

  describe '#initialize' do
    it 'initializes the file path' do
      expect(parser.instance_variable_get(:@file_path)).to eq file_path
    end

    it 'reads the files content' do
      expect(parser.instance_variable_get(:@file_content)).to_not be_empty
    end
  end

  describe '#parse' do
    it 'initializes current_game and players' do
      expect(subject).to receive(:start_game?).at_least(:twice).and_return(true)
      subject.parse
      expect(subject.instance_variable_get(:@games)).to_not be_empty
      expect(subject.instance_variable_get(:@players)).to be_nil
    end
  end

  describe '#new_game' do
    it 'creates a new game' do
      expect(Game).to receive(:new).with(1)
      subject.send(:new_game, [])
    end
  end

  describe '#start_game?' do
    it 'checks if the line contains InitGame' do
      line = "InitGame: \\sv_floodProtect\\1\\sv_maxPing\\0\\sv_minPing\\0\\sv_maxRate\\10000\\sv_minRate\\0\\sv_hostname\\Code Miner Server\\g_gametype\\0\\sv_privateClients\\2\\sv_maxclients\\16\\sv_allowDownload\\0\\dmflags\\0\\fraglimit\\20\\timelimit\\15\\g_maxGameClients\\0\\capturelimit\\8\\version\\ioq3 1.36 linux-x86_64 Apr 12 2009\\protocol\\68\\mapname\\q3dm17\\gamename\\baseq3\\g_needpass\\0"
      expect(subject.send(:start_game?, line)).to be true
    end
  end

  describe '#killer_victim' do
    it 'returns the killer and victim from the line' do
      expect(subject.send(:killer_victim, "Kill: 2 3 7: Isgalamido killed Mocinha by MOD_ROCKET_SPLASH")).to eq(['Isgalamido', 'Mocinha'])
    end
  end

  describe '#print_report' do
    before do
      @game = Game.new(1)
      player1 = Player.new("Player1")
      player2 = Player.new("Player2")
      player3 = Player.new("Player3")
      player1.kills = 19
      player2.kills = 20
      player3.kills = 21
      @game.players = { "Player1" => player1, "Player2" => player2, "Player3" => player3}
    end

    it 'prints a report of the leaderboard of the games' do
      output = StringIO.new
      $stdout = output
      @game.print_report
      expected_output = "Game 1 Leaderboard:\nPlayer3 - 21 kills\nPlayer2 - 20 kills\nPlayer1 - 19 kills\n"
      expect(output.string).to eq(expected_output)
    end
  end
end