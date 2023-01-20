class Player
  attr_accessor :name, :kills, :deaths

  def initialize(name)
    @name = name
    @kills = 0
    @deaths = 0
  end

  def add_kill
    @kills += 1
  end

  def lose_kill
    @kills -= 1
  end

  def add_death
    @deaths += 1
  end

  def who_killed_who(victim)
    if victim == @name
      @deaths +=1
      @kills -= 1
    else
      @kills +=1
      @deaths +=1
    end
  end

  def kda
    @deaths.zero? ? @kills.to_f : (@kills.to_f / @deaths.to_f).round(2)
  end

  def stats
    {
      kills: @kills,
      deaths: @deaths,
      kda: kda
    }
  end
end