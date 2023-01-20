require 'parser'
require 'game'
require 'player'

describe Player do
  subject(:player) { Player.new("Player1") }

  describe "#initialize" do
    it "should have a name" do
      expect(player.name).to eq("Player1")
    end

    it "should have 0 kills and deaths" do
      expect(player.kills).to eq(0)
      expect(player.deaths).to eq(0)
    end
  end

  describe "#add_kill" do
    it "should increase the number of kills by 1" do
      player.add_kill
      expect(player.kills).to eq(1)
    end
  end

  describe "#lose_kill" do
    it "should decrease the number of kills by 1" do
      player.lose_kill
      expect(player.kills).to eq(-1)
    end
  end

  describe "#add_death" do
    it "should increase the number of deaths by 1" do
      player.add_death
      expect(player.deaths).to eq(1)
    end
  end

  describe "#who_killed_who" do
    context "when the victim is the player" do
      it "should increase the number of deaths by 1 and decrease the number of kills by 1" do
        player.who_killed_who("Player1")
        expect(player.deaths).to eq(1)
        expect(player.kills).to eq(-1)
      end
    end
  end
end