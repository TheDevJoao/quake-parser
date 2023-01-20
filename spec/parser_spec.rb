require 'rspec'
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
      expect(subject).to receive(:new_game).with([]).and_return(Game.new(1))
      expect(subject).to receive(:start_game?).and_return(true)
      expect(subject).to receive(:kill_line?).and_return(false)
      subject.parse
      expect(subject.instance_variable_get(:@current_game)).to_not be_nil
      expect(subject.instance_variable_get(:@players)).to_not be_nil
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
end