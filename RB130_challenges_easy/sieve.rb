class Sieve

  def initialize(end_point)
    @array = (2..end_point).to_a
  end

  def primes
    not_primes = []
    primes = []
    @array.each_with_index do |num, idx|
      if not_primes.include?(num)
        next
      else
        primes << num
        marked_array = @array[(idx + 1)..-1].select { |bigger_num| bigger_num % num == 0 } 
        not_primes += marked_array
      end
    end
    primes
  end
  
end

test = Sieve.new(100)
p test.primes