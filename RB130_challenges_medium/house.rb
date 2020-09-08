class House
  def self.recite
    new.recite
  end

  def recite
    rhyme = pieces.reverse
    other_lines = 0
    answer = ''
    rhyme.size.times do |index|
      answer << "This is #{rhyme[index][0]}"
      other_lines.downto(1) do |inner_index|
        answer << "\n#{rhyme[inner_index][1]} #{rhyme[inner_index - 1][0]}"
      end
      answer << ".\n\n"
      other_lines += 1
    end
    answer[0...-1]
  end

  private

  def pieces
    [
      ['the horse and the hound and the horn', 'that belonged to'],
      ['the farmer sowing his corn', 'that kept'],
      ['the rooster that crowed in the morn', 'that woke'],
      ['the priest all shaven and shorn', 'that married'],
      ['the man all tattered and torn', 'that kissed'],
      ['the maiden all forlorn', 'that milked'],
      ['the cow with the crumpled horn', 'that tossed'],
      ['the dog', 'that worried'],
      ['the cat', 'that killed'],
      ['the rat', 'that ate'],
      ['the malt', 'that lay in'],
      ['the house that Jack built']
    ]
  end
end
