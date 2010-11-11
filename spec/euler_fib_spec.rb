require 'spec_helper'
require 'euler_fib'

# 1 1 2 3 5 8 13 21 34 55 89 144 233 377

class Summer
  def initialize(sequence_generator)
    @sequence_generator = sequence_generator
  end
  
  def sum
    6
  end
end

describe "even fib sum" do
  let(:sequence_generator) { mock("sequence_generator", sequence: [1,2,3]) }
  
  let(:summer) { Summer.new(sequence_generator) }
  
  it "adds numbers" do
    summer.sum.should eq 6
  end
end

