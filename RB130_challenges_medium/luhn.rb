class Luhn
  def initialize(int)
    @number = int
  end

  def addends
    digits_arr = @number.digits.map.with_index do |num, idx|
      if idx.odd?
        num * 2 > 9 ? (num * 2) - 9 : num * 2
      else
        num
      end
    end
    digits_arr.reverse
  end

  def checksum
    addends.sum
  end

  def valid?
    checksum % 10 == 0
  end

  def self.create(int)
    result = Luhn.new(int * 10)
    return int * 10 if result.valid?
    sum = result.checksum
    (int * 10) + (10 - (sum % 10))
  end
end
