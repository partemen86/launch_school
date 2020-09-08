# Write a simple linked list implementation that uses Elements and a List.

# The linked list is a fundamental data structure in computer science,

# often used in the implementation of other data structures.

# The simplest kind of linked list is a singly linked list.

# Each element in the list contains data and a "next" field pointing

# to the next element in the list of elements. This variant of linked

# lists is often used to represent sequences or push-down stacks

# (also called a LIFO stack; Last In, First Out).

# Lets create a singly linked list to contain the range (1..10),

# and provide functions to reverse a linked list and convert to and from arrays.

class SimpleLinkedList
  attr_accessor :size, :head

  def initialize
    @size = 0
    @head = nil
  end

  def empty?
    size == 0
  end

  def push(data)
    self.size += 1
    next_element = @head
    self.head = Element.new(data, next_element)
  end

  def pop
    result = peek
    self.head = head.next
    self.size -= 1
    result
  end

  def peek
    head&.datum
  end

  def self.from_a(arr)
    new_list = new
    arr&.reverse&.each { |value| new_list.push(value) }
    new_list
  end

  def to_a
    array = []
    dup_list = clone
    array.push(dup_list.pop) while !dup_list.empty?
    array
  end

  def reverse
    SimpleLinkedList.from_a(to_a.reverse)
  end
end

class Element
  attr_reader :datum, :next

  def initialize(data, next_element = nil)
    @datum = data
    @next = next_element
  end

  def tail?
    !@next
  end
end
