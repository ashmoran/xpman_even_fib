require 'spec_helper'
require 'euler_fib'

class FibSequenceGenerator
  
end

class EvenFibSummator
  
end

describe EvenFibSummator do
  let(:even_fib_summator) { EvenFibSummator.new }
  it "creates FibSequenceGenerator" do
    FibSequenceGenerator.should_receive(:new)
    even_fib_summator.sum
  end
end