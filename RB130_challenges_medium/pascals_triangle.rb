class Triangle
  def initialize(max)
    @triangle = Array.new(max)
  end

  def rows
    @triangle.map!.with_index do |_, idx|
      next_row(idx)
    end
  end

  def next_row(idx)
    return [1] if idx == 0
    (prev_row = [0] + @triangle[idx - 1] + [0])
    prev_row.each_cons(2).map { |left, right| left + right }
  end
end
