require File.dirname(__FILE__) + "/spec_helper"

describe Grab do
  
  describe "Grabbing 'a' or 'an' record" do
    
    it "should return one record if number is 'a'" do
      @user = Grab.a_user
      @user.is_a?(User).should be_true
    end
    
    it "should return one record if number is 'an'" do
      @user = Grab.an_user
      @user.is_a?(User).should be_true
    end

  end
  
  describe "Grabbing various number combinations" do
    
    it "should return the record if number is one" do
      @user = Grab.one_user
      @user.is_a?(User).should be_true
    end
    
    it "should grab the correct number of records each time" do
      # random number between 1 and 99
      random_number = (rand * 99).ceil
      # return the number name eg. sixty_one
      random_name = Grab::ALL_NUMBERS.invert[random_number]
      @users = Grab.send("#{random_name}_users")
      @users.size.should == random_number
    end
  
  end
  
  describe "Grabbing existing records" do
    
    before do
      Factory :user unless User.all.any?
    end
    
    it "should not create a new record if there is one present" do
      lambda { Grab.one_user }.should_not change { User.count }
    end
    
  end
  
  describe "Grabbing non-existing records" do
  
    before do
      User.destroy_all
    end
    
    it "should create a new record" do
      lambda { Grab.one_user }.should change { User.count }.by(1)
    end
  
  end
  
  describe "Grabbing a mixture of existing and non-existing records" do
    
    before do
      User.destroy_all
      2.times { Factory :user }
    end
    
    it "should only create one extra record" do
      lambda { Grab.three_users }.should change { User.count }.by(1)
    end
    
  end
  
  describe "Grabbing factories with virtual attributes" do
    # Attributes such as password can be set when creating factories but may not have a corresponding
    # column on the database (ie. they are virtual attributes)
    # In such cases, to ensure the record has the desired attributes, a new factory should be created
    
    it "should create a new factory if attributes are not all in the database" do
      Grab.one_user(:password => "password")
      lambda { Grab.one_user(:password => "password")}.should change { User.count }.by(1)
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