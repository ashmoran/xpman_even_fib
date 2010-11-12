class Summator
  def initialize(sequence_generator)
    @sequence_generator = sequence_generator
  end
  
  def sum
    @sequence_generator.sequence.inject(:+)
  end
end

class EvenPicker
  def initialize(sequence_generator)
    @sequence_generator = sequence_generator
  end
  
  def sequence
    @sequence_generator.sequence.select(&:even?)
  end
end

class LimitedSequenceGenerator
  def initialize(incremental_sequence_generator, limit)
    @incremental_sequence_generator = incremental_sequence_generator
    @limit = limit
  end
  
  def sequence
    seq = [ ]
    while (next_value = @incremental_sequence_generator.next) < @limit
      seq << next_value
    end
    seq
  end
end

class IncrementalFibSequenceGenerator
  def initialize
    @count = 0
    @fib_sequence = [1, 1]
  end
  
  def next
    @count += 1
    if @count == 1 or @count == 2
      @fib_sequence[@count - 1]
    else
      @fib_sequence[@count - 1] + @fib_sequence[@count - 2]
    end
  end
end

class EvenFibSummator
  def initialize(limit)
    @limit = limit
  end
  
  def sum
    Summator.new(EvenPicker.new(LimitedSequenceGenerator.new(IncrementalFibSequenceGenerator.new, @limit))).sum
  end
end
