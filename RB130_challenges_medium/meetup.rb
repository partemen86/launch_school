# Define a class Meetup with a constructor taking a month and a year
# and a method day(weekday, schedule)
# where weekday is one of :monday, :tuesday, etc
# and schedule is :first, :second, :third, :fourth, :last or :teenth.
require 'date'

class Meetup
  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(weekday, schedule)
    temp_date = Date.new(@year, @month, LOOKUP[schedule])
    temp_date += 1 until temp_date.send("#{weekday}?")
    temp_date
  end

  private

  LOOKUP = {first: 1, second: 8, third: 15, fourth: 22, last: -7, teenth: 13}

end
