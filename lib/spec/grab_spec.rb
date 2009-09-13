require File.dirname(__FILE__) + "/spec_helper"

describe Grab do
  
  it "should respond to number methods between one and one hundred" do
    Grab.one.should == 1
    Grab.twelve.should == 12
    Grab.twenty_three.should == 23
    Grab.thirty_four.should == 34
    Grab.forty_five.should == 45
    Grab.fifty_six.should == 56
    Grab.sixty_seven.should == 67
    Grab.seventy_eight.should == 78
    Grab.eighty_nine.should == 89
    Grab.ninety.should == 90
  end
  
  it "should raise an error if factory name is not provided" do
    lambda {Grab.forty_four_monsters}.should raise_error(NameError)
  end
  
  it "should raise an error if method is not a valid number" do
    lambda {Grab.forty_forty_users}.should raise_error(NoMethodError)
  end
  
  it "should not create a new record if there is one present in db" do
    Factory(:user) unless User.all.any?
    Factory.should_not_receive(:create).with(:user)
    Grab.twenty_one_users
  end
  
  it "should create a new record if there aren't any present" do
    User.destroy_all
    Factory.should_receive(:create).with(:user, :last_name => "Smith")
    Grab.one_user :last_name => "Smith"
  end
  
  it "should accept conditions/attributes as options" do
    @users = Grab.two_users(:first_name => "John")
    @users.count.should == 2
    @users.detect { |u| u.first_name != "John" }.should be_nil
  end

end