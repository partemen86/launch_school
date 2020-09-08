class School
  def initialize
    @school = Hash.new([])
  end

  def to_h
    @school.sort.to_h
  end

  def add(name, grade)
    @school[grade] += [name]
    @school[grade].sort!
  end

  def grade(grade)
    school[grade]
  end

  private

  attr_accessor :school

end
