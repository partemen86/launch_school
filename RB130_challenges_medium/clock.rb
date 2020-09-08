class Clock
  def self.at(hours, minutes = 0)
    Clock.new(hours, minutes)
  end

  def +(add_minutes)
    self.hours, self.minutes = (in_minutes + add_minutes).divmod(60)
    self.hours = hours % 24
    self
  end

  def -(subtract_minutes)
    self.hours, self.minutes = (in_minutes - subtract_minutes).divmod(60)
    self.hours = hours % 24
    self
  end

  def to_s
    format("%02d:%02d", hours, minutes)
  end

  def ==(other)
    to_s == other.to_s
  end

  protected

  attr_accessor :hours, :minutes
  
  def initialize(hours, minutes)
    @hours = hours
    @minutes = minutes
  end

  def in_minutes
    hours * 60 + minutes
  end
end
