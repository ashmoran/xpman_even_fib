require 'spec_helper'
require 'euler_fib'

class FibSequenceGenerator
  
end

class FibSequenceGenerator
  
end

class EvenFibSummator
  def sum
    FibSequenceGenerator.new
  end
end

describe EvenFibSummator do
  let(:fib_sequence_generator) { mock(FibSequenceGenerator) }
  let(:even_fib_summator) { EvenFibSummator.new }

  it "creates a FibSequenceGenerator" do
    FibSequenceGenerator.should_receive(:new)
    even_fib_summator.sum
  end
  
  it "creates a EvenPicker with the FibSequenceGenerator" do
    EvenPicker.should_receive(:new).with(fib_sequence_generator)
    even_fib_summator.sum
  end
end