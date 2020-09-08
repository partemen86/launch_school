class DNA

  def initialize(str)
    @dna = str
  end

  def hamming_distance(other_dna)
    counter = 0
    shorter_strand, longer_strand = [@dna, other_dna].sort_by(&:size)
    shorter_strand.each_char.with_index do |value, idx|
      counter += 1 unless value == longer_strand[idx]
    end
    counter
  end

end
