# NOTE: This bit done in Paul Barrett's car on the way back to Stoke

require 'spec_helper'
require 'euler_fib'

# 1 1 2 3 5 8 13 21 34 55 89 

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

class FibSequenceGenerator
  
end

class EvenFibSummator
  def initialize(limit)
    @limit = limit
  end
  
  def sum
    Summator.new(EvenPicker.new(FibSequenceGenerator.new(@limit))).sum
  end
end

describe EvenPicker do
  let(:sequence_generator) { mock("SequenceGenerator", sequence: [1,2,3,4,5,6,7,8])}
  let(:even_picker) { EvenPicker.new(sequence_generator) }
  
  it "picks even numbers" do
    even_picker.sequence.should eq [2,4,6,8]
  end
end

describe Summator do
  let(:sequence_generator) { mock("SequenceGenerator", sequence: [1,2,3])}
  let(:summator) { Summator.new(sequence_generator) }
  
  it "sums numbers" do
    summator.sum.should eq 6
  end
end

describe EvenFibSummator do
  it "works" do
    EvenFibSummator.new(35).sum.should eq 44
  end
end

describe EvenFibSummator do
  let(:summator) { mock(Summator, sum: 1) }
  let(:even_picker) { mock(EvenPicker) }
  let(:fib_sequence_generator) { mock(FibSequenceGenerator) }
  let(:even_fib_summator) { EvenFibSummator.new(2) }
  
  before(:each) {
    FibSequenceGenerator.stub(new: fib_sequence_generator)
    EvenPicker.stub(new: even_picker)
    Summator.stub(new: summator)
  }

  it "creates a FibSequenceGenerator" do
    FibSequenceGenerator.should_receive(:new).with(2)
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
  
  it "asks the Summator for the sum" do
    summator.should_receive(:sum)
    even_fib_summator.sum.should eq 1
  end  
end