class WordProblem
  OPERATIONS = {
    'plus' => :+, 'minus' => :-,
    'multiplied' => :*, 'divided' => :/
  }

  def initialize(str)
    @problem = str
    @total = nil
  end

  def answer
    operation = nil
    @problem.split.each do |word|
      if word =~ (/\-?\d+/)
        @total = @total ? @total.send(operation, word.to_i) : @total = word.to_i
      elsif OPERATIONS.keys.include? word
        operation = OPERATIONS[word]
      end
    end

    raise ArgumentError unless @total && operation
    @total
  end
end
