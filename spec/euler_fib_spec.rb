require 'spec_helper'
require 'euler_fib'

# 1 1 2 3 5 8 13 21 34 55 89 144 233 377

class Summator
  def initialize(sequence_generator)
    @sequence_generator = sequence_generator
  end
  
  def sum
    @sequence_generator.sequence.inject(:+)
  end
end

class EvenPicker
  
end

class EvenSummator
  def initialize(sequence_generator)
    @sequence_generator = sequence_generator
  end
  
  def sum
    EvenPicker.new(@sequence_generator)
  end
end

describe "even fib sum" do
  let(:sequence_generator) { mock("sequence_generator", sequence: [1,2,3]) }
  
  let(:summator) { Summator.new(sequence_generator) }
  
  it "adds numbers" do
    summator.sum.should eq 6
  end
end

describe EvenSummator do
  let(:sequence_generator) { mock("sequence_generator") }
  let(:even_picker) { mock(EvenPicker) }
  let(:even_summator) { EvenSummator.new(sequence_generator) }
  
  before(:each) do
    # EvenPicker.
  end
  
  specify "sum" do
    EvenPicker.should_receive(:new).with(sequence_generator)
    even_summator.sum
  end
  
  specify "sum" do
    Summator.should_receive(:new).with(even_picker)
    even_summator.sum
  end
end