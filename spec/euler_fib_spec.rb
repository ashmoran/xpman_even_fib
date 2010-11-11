require 'spec_helper'
require 'euler_fib'

# 1 1 2 3 5 8 13 21 34 55 89 144 233 377

def even_fib_sum(n)
  if n < 2
    0
  else
    2
  end
end

describe "euler_fib" do
  specify { even_fib_sum(1).should eq 0 }
  specify { even_fib_sum(2).should eq 0 }
  specify { even_fib_sum(3).should eq 2 }
end