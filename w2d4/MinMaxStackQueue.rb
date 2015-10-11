class MyStack
  def initialize
    @store = []
  end

  def pop
    @store.pop
  end

  def push(item)
    @store << item
  end

  def peek
    puts @store[-1]
  end

  def empty?
    @store.empty?
  end

end # class end





class MyStackQueue
  def initialize
    @pass_through = MyStack.new
    @queue = MyStack.new
  end

  def enqueue(item)
    @pass_through.push(item)
  end

  def dequeue
    if @queue.empty?
      @queue.push(@pass_through.pop) until @pass_through.empty?
    end
    @queue.pop
  end

  def size
    @queue.size
  end

end #class end










end
