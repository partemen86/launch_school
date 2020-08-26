require 'simplecov'
SimpleCov.start

require 'minitest/autorun'

require_relative 'todolist'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_sx
    assert(@todo1.title == "gym")
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    shifted = @list.shift
    assert_equal(@todo1, shifted)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    popped = @list.pop
    assert_equal(@todo3, popped)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    assert_equal(false, @list.done?)

    @todo1.done!
    @todo2.done!
    @todo3.done!
    assert_equal(true, @list.done?)
  end

  def test_error_raised
    assert_raises(TypeError) { @list.add(5) }
    #assert_raises(TypeError) { @list.add(@todo1) }
  end

  def test_shovel
    @list << @todo1
    assert_equal([@todo1, @todo2, @todo3, @todo1], @list.to_a)
  end

  def test_add
    new_todo = Todo.new("Walk the cat")
    @list.add(new_todo)
    @todos << new_todo
    assert_equal(@todos, @list.to_a)
  end

  def test_item_at
    assert_equal(@todo2, @list.item_at(1))
    assert_raises(IndexError) { @list.item_at(5)}
  end

  def test_mark_done_at
    assert_raises(IndexError) { @list.mark_done_at(5)}
    @list.mark_done_at(1)
    assert_equal(true, @todo2.done?)
  end

  def test_mark_undone_at
    assert_raises(IndexError) { @list.mark_undone_at(5)}
    @list.mark_done_at(1)
    assert_equal(true, @todo2.done?)
    refute_equal(@todo2.done?, @list.mark_undone_at(1))
  end

  def test_done_all
    @list.done!
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
    assert_equal(true, @list.done?)
  end

  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(5)}
    @list.remove_at(1)
    assert_equal([@todo1,@todo3], @list.to_a)
  end

  def test_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT
  
    assert_equal(output, @list.to_s)

    output2 = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [X] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT
    @todo1.done!
    assert_equal(output2, @list.to_s)

    output3 = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT
    @list.done!
    assert_equal(output3,@list.to_s)
  end

  def test_each
    @list.each(&:done!)
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)

    result = []
    return_value = @list.each { |todo| result << todo }
    assert_equal(@list, return_value)
  end

  def test_select
    @todo1.done!
    assert_equal([@todo1], @list.select(&:done?).to_a)
  end

  def test_find_by_title
    assert_nil(@list.find_by_title("homework"))
    assert_equal(@todo2, @list.find_by_title("Clean room"))
  end

  def test_all_done
    @todo3.done!
    assert_equal([@todo3], @list.all_done.to_a)
  end

  def test_all_not_done
    @todo3.done!
    assert_equal([@todo1,@todo2], @list.all_not_done.to_a)
  end

  def test_mark_done
    @list.mark_done("Clean room")
    assert_equal([@todo2], @list.all_done.to_a)
  end

  def test_mark_all_done
    @list.mark_all_done
    assert_equal(@todos, @list.all_done.to_a)
  end

  def test_mark_all_undone
    @todos.each(&:done!)
    assert_equal(@todos, @list.all_done.to_a)
    @list.mark_all_undone
    assert_equal(@todos, @list.all_not_done.to_a)
  end





  # Your tests go here. Remember they must start with "test_"

end
