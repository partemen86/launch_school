class Integer

  ROMAN_NUMERALS = {
    1 => %w(I II III IV V VI VII VIII IX), 
    10 => %w(X XX XXX XL L LX LXX LXXX XC),
    100 => %w(C CC CCC CD D DC DCC DCCC CM),
    1000 => %w(M MM MMM)
  }
  
  def to_roman
    result = []
    self.digits.each_with_index do |value, idx|
      next if value == 0
      result << ROMAN_NUMERALS[(10 ** idx)][value-1]
    end
    result.reverse.join
  end

end

