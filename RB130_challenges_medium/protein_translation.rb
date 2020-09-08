class InvalidCodonError < StandardError
end

class Translation

  KEY = {
    %w(AUG) => 'Methionine', %w(UUU UUC) => 'Phenylalanine',
    %w(UUA UUG) => 'Leucine', %w(UCU UCC UCA UCG) => 'Serine',
    %w(UAU UAC) => 'Tyrosine', %w(UGU UGC) => 'Cysteine',
    %w(UGG) => 'Tryptophan', %w(UAA UAG UGA) => 'STOP'
  }

  def self.of_codon(codon)
    result = nil
    KEY.each_key do |arr|
      result = KEY[arr] if arr.include?(codon)
    end
    result || (raise InvalidCodonError, 'MISS')
  end

  def self.of_rna(strand)
    strand.scan(/.../).each_with_object([]) do |codon, proteins|
      protein = Translation.of_codon(codon)
      return proteins if protein == 'STOP'
      proteins << protein
    end

  end

end

