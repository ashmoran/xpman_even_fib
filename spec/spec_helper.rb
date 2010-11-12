require 'bundler'
Bundler.require(:default, :test)

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib"))

module SpecHelperObjectExtensions
  def contract(name, &block)
    shared_examples_for(name, &block)
  end
end

include SpecHelperObjectExtensions

RSpec.configure do |c|
  c.alias_it_should_behave_like_to(:it_satisfies_contract, 'satisfies contract:')
end
