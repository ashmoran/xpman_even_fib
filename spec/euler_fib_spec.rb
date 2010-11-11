require 'spec_helper'
require 'euler_fib'

class Summator
  
end

class EvenPicker
  
end

class FibSequenceGenerator
  
end

class EvenFibSummator
  def sum
    Summator.new(EvenPicker.new(FibSequenceGenerator.new))
  end
end

describe EvenFibSummator do
  let(:even_picker) { mock(EvenPicker) }
  let(:fib_sequence_generator) { mock(FibSequenceGenerator) }
  let(:even_fib_summator) { EvenFibSummator.new }
  
  before(:each) {
    FibSequenceGenerator.stub(new: fib_sequence_generator)
    EvenPicker.stub(new: even_picker)
  }

  it "creates a FibSequenceGenerator" do
    FibSequenceGenerator.should_receive(:new)
    even_fib_summator.sum
  end
  
  it "creates a EvenPicker with the FibSequenceGenerator" do
    EvenPicker.should_receive(:new).with(fib_sequence_generator)
    even_fib_summator.sum
  end
  
  it "creates a Summator with the EvenPicker" do
    Summator.should_receive(:new).with(even_picker)
    even_fib_summator.sum
  end
end