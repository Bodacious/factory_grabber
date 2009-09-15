require File.dirname(__FILE__) + "/spec_helper"

describe Grab do
  
  describe "Grabbing various number combinations" do
    
    it "should grab the correct number of records each time" do
      @users = Grab.ninety_users
      @users.size.should == 90
      
      @users = Grab.one_user
      @users.size.should == 1

      @users = Grab.twelve_users
      @users.size.should == 12

      @users = Grab.twenty_three_users
      @users.size.should == 23

      @users = Grab.thirty_four_users
      @users.size.should == 34
      
      @users = Grab.forty_five_users
      @users.size.should == 45

      @users = Grab.fifty_six_users
      @users.size.should == 56
      
      @users = Grab.sixty_seven_users
      @users.size.should == 67
      
      @users = Grab.seventy_eight_users
      @users.size.should == 78
      
      @users = Grab.eighty_nine_users
      @users.size.should == 89
      

    end


  
  end
  
  describe "Grabbing existing records" do
    
    before do
      Factory :user unless User.all.any?
    end
    
    it "should not create a new record if there is one present" do
      Factory.should_not_receive(:create).with(:user, {})
      Grab.one_user
    end
    
  end

  describe "Grabbing non-existing records" do

    before do
      User.destroy_all
    end
    
    it "should create a new record" do
      Factory.should_receive(:create).with(:user, {})
      Grab.one_user
    end

  end
  
  describe :number_name do
    
    it "should return the correct number if it's a unit" do
      Grab.one_user
      Grab.send(:number_name).should == 'one'
    end
    
    it "should return the correct number if it's a teen'" do
      Grab.eleven_users
      Grab.send(:number_name).should == 'eleven'
    end
    
    it "should return the correct number if it's a double-digit" do
      Grab.twenty_one_users
      Grab.send(:number_name).should == 'twenty_one'
    end
    
    it "should return the correct number if it's a ten" do
      Grab.twenty_users
      Grab.send(:number_name).should == 'twenty'
    end
    
  end
  
  describe :number do
    
    it "should return the correct number if it's a unit" do
      Grab.four_users
      Grab.send(:number).should == 4
    end
    
    it "should return the correct number if it's a teen'" do
      Grab.twelve_users
      Grab.send(:number).should == 12
    end
    
    it "should return the correct number if it's a double-digit" do
      Grab.twenty_one_users
      Grab.send(:number).should == 21
    end
    
    it "should return the correct number if it's a ten" do
      Grab.twenty_users
      Grab.send(:number).should == 20
    end
    
  end
  
  describe :klass_name do
    
    it "should return the name of the factory class as a constant if available" do
      Grab.one_user
      Grab.send(:klass_name).should == "user"
    end
    
  end
    
  describe :klass_name_constant do
    
    it "should return the class name as a constant" do
      Grab.one_user
      Grab.send(:klass_name_constant).should == User
    end
    
  end
  
  describe :required_records do
    
    before do
    end
    
    it "should return nil if no records are required" do
      count = User.count
      if count < 4
        (4 - count).times { Factory(:user) }
      end
      Grab.three_users
      Grab.send(:required_records).should be_nil
    end

    
  end
  
end