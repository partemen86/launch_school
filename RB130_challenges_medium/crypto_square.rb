class Crypto
  def initialize(msg)
    @msg = msg
  end

  def normalize_plaintext
    @msg.gsub(/[\W_]/, '').downcase
  end

  def size
    Math.sqrt(normalize_plaintext.length).ceil
  end

  def plaintext_segments
    normalize_plaintext.scan(/.{1,#{size}}/)
  end

  def ciphertext
    normalize_ciphertext.split.join
  end

  def normalize_ciphertext
    result = []
    index = 0
    until index >= plaintext_segments[0].length
      new_word = ''
      plaintext_segments.each do |segment|
        new_word << segment[index] if segment[index]
      end
      result << new_word
      index += 1
    end
    result.join(' ')
  end
end
