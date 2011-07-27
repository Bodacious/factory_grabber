require File.dirname(__FILE__) + "/spec_helper"
require "benchmark"

# runs a quick benchmark to compare the two
Benchmark.bmbm do |test|
  test.report("Create 50 new factories") do
    50.times { Factory :user, :first_name => "John", :admin => false }
  end
  
  until User.count >= 50
    Factory :user, :last_name => "Smith", :admin => true
  end
  
  test.report("Grab 50 separate factories") do
    50.times { Grab.one_user :last_name => "Smith", :admin => true }
  end
  
  test.report("Grab 50 factories at once") do
    Grab.fifty_users :last_name => "Smith", :admin => true
  end
  
end