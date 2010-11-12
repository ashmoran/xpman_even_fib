require 'spec_helper'
require 'euler_fib'

describe IncrementalFibSequenceGenerator do
  let(:incremental_sequence_generator) { IncrementalFibSequenceGenerator.new }
  
  def fib(n)
    fib = nil
    n.times do
      fib = incremental_sequence_generator.next
    end
    fib
  end
  
  specify { fib(1).should eq 1 }
  specify { fib(2).should eq 1 }
  specify { fib(3).should eq 2 }
  specify { fib(4).should eq 3 }
end

describe LimitedSequenceGenerator do
  let(:incremental_sequence_generator) {
    isq = mock("IncrementalSequenceGenerator")
    isq.stub(:next).and_return(1, 4, 3, 8, 12)
    isq
  }
  
  it "collects all if none are >= the limit" do
    # Actually, we will assume IncrementalSequenceGenerator#next produces an infinite sequence
  end
  
  it "collects values until one value is returned that is equal the limit" do
    LimitedSequenceGenerator.new(incremental_sequence_generator, 8).sequence.should eq [1, 4, 3]
  end
  
  it "collects values until one value is returned that is greater than limit" do
    LimitedSequenceGenerator.new(incremental_sequence_generator, 9).sequence.should eq [1, 4, 3, 8]
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
  subject { Summator.new(sequence_generator) }
  
  its(:sum) { should eq 6 }
  
  # it "sums numbers" do
  #   summator.sum.should eq 6
  # end
end

describe EvenFibSummator do
  it "works" do
    EvenFibSummator.new(35).sum.should eq 44
  end
  
  it "works for 4 000 000" do
    EvenFibSummator.new(4_000_000).sum.should eq 4613732
  end
end

describe EvenFibSummator do
  let(:summator) { mock(Summator, sum: 1) }
  let(:even_picker) { mock(EvenPicker) }
  let(:limited_sequence_generator) { mock(LimitedSequenceGenerator) }
  let(:fib_sequence_generator) { mock(IncrementalFibSequenceGenerator) }
  let(:even_fib_summator) { EvenFibSummator.new(2) }
  
  before(:each) {
    IncrementalFibSequenceGenerator.stub(new: fib_sequence_generator)
    LimitedSequenceGenerator.stub(new: limited_sequence_generator)
    EvenPicker.stub(new: even_picker)
    Summator.stub(new: summator)
  }

  it "creates a IncrementalFibSequenceGenerator" do
    IncrementalFibSequenceGenerator.should_receive(:new)
    even_fib_summator.sum
  end
  
  it "creates a LimitedSequenceGenerator with the IncrementalFibSequenceGenerator and the limit" do
    LimitedSequenceGenerator.should_receive(:new).with(fib_sequence_generator, 2)
    even_fib_summator.sum
  end
  
  it "creates a EvenPicker with the IncrementalFibSequenceGenerator" do
    EvenPicker.should_receive(:new).with(limited_sequence_generator)
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