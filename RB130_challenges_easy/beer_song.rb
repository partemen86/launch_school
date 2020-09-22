# Write a program that can generate the lyrics of the 99 Bottles of Beer song.
# See the test suite for the entire song.

class BeerSong
  def verse(int)
    if int == 2
      "2 bottles of beer on the wall, 2 bottles of beer.\n"  \
      "Take one down and pass it around, 1 bottle of beer on the wall.\n"
    elsif int == 1
      "1 bottle of beer on the wall, 1 bottle of beer.\n"  \
      "Take it down and pass it around, no more bottles of beer on the wall.\n"
    elsif int == 0
      "No more bottles of beer on the wall, no more bottles of beer.\n"  \
      "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
    else
      "#{int} bottles of beer on the wall, #{int} bottles of beer.\n"  \
      "Take one down and pass it around, #{int - 1} bottles of beer on the wall.\n"
    end
  end

  def verses(start, finish)
    result = ''
    start.downto(finish) do |num|
      result += verse(num) + "\n"
    end
    result.chomp
  end

  def lyrics
    verses(99, 0)
  end
end
