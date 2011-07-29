Factory Grabber
==============

Factory grabber speeds up your tests by grabbing the nearest appropriate database records to suit your needs.

The idea is simple: most of the time, when using factories, you don't really care about the specific attributes, you just need a database record to play with. factory_grabber will *'grab'* a matching record from the database if available or create any extra records if required. Less inserts to the database means faster tests.

At the moment, only [factory_girl](http://github.com/thoughtbot/factory_girl) by thoughtbot is supported. If you'd like to see more factories supported please let me know.

To install:
===========

``` ruby
gem install git://github.com/GavinM/factory_grabber.git

# Gemfile
group :test do
	gem "factory_girl_rails"
	gem "factory_grbber"
end
```

Important:
----------
		
To benefit from this gem, set use_transactional_fixtures=() to false in *spec_helper.rb*
	
```	ruby
Spec::Runner.configure do |config|
  config.use_transactional_fixtures = false
	config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
end
```

Example Usage
=============

First, add the following line to *spec_helper.rb* or *test_helper.rb*:

``` ruby
require "factory_grabber"
```

Then, in your tests/specs:
		
``` ruby
# to grab 1 comment:
@comment = Grab.a_comment

# to grab 1 article:
@article = Grab.an_article

#to grab 4 users named "John Smith":
@users = Grab.four_users(:first_name => "John", :last_name => "Smith")

#to grab 73 users with standard factory attributes:
@users = Grab.seventy_three_users
```

Practical examples:
===================

In a controller spec...

```
describe "GET /posts/1" do

  integrate_views

  before do
		# will create a record with these attributes if required, if not it will find the existing record
  	@post = Grab.one_post :title => "This is my first post", :body => "This is the post body"
  end

  def	do_get
  	get :show, :id => @post
  end

  it "should show the post title" do
  	do_get
  	response.should include_text(/This is my first post/)
  end

	it "should show the post body" do
		do_get
		response.should include_text(/This is the post body/)
	end

end


describe "GET /posts?page=1" do

	# testing pagination

	integrate_views

	before do
		# ensures there are at least eleven Post records
		# if there are less than eleven, new posts are created
		# if there are eleven or more no posts are created
		Grab.eleven_posts
	end

	def	do_get
		get :index, :page => 1
	end

	it "should find the latest 10 posts" do
		do_get
		assigns[:posts].should == Post.find(:all, :order => "created_at DESC", :limit => 10)
	end

end
```

At the moment, all numbers between one and ninety_nine are supported. The general syntax for Grab methods is:

``` ruby
Grab.[number_in_words]_[factory_name]
```

Performance gains
==================

Here's a quick example of the possible performance gains:
<pre>
Rehearsal --------------------------------------------------------------
Create 50 new factories      0.130000   0.200000   0.330000 (  6.785332)
Grab 50 separate factories   0.320000   0.020000   0.340000 (  0.332814)
Grab 50 factories at once    0.010000   0.000000   0.010000 (  0.012414)
----------------------------------------------------- total: 0.680000sec

                                 user     system      total        real
Create 50 new factories      0.100000   0.200000   0.300000 (  6.354282)
Grab 50 separate factories   0.300000   0.000000   0.300000 (  0.310373)
Grab 50 factories at once    0.020000   0.000000   0.020000 (  0.011400)
</pre>

(These results can be produced for your own environment by running the file "performance_test.rb" in factory_grabber/lib/spec/performance_test.rb)

Known Issues
============

At the moment, existing factories are found calling the model name. If your factory names do not match the name of the models then new factories will be created each time.
eg.

		Factory(:admin_user, :class => :user) do |f|
		  f.username("admin_user")
			f.admin(true)
			# ... etc ...
		end

		Grab.an_admin_user # => will not find records from the database.

Feedback
========

This project is still an infant - if the Ruby community find it useful I plan on adding a lot more. Please send any ideas/feedback to gavin@handyrailstips.com


Free to upload, edit, share, fork etc.

[Gavin Morrice](http://gavinmorrice.com)
Travis CI: [![Build Status](http://travis-ci.org/Bodacious/factory_grabber.png)](http://travis-ci.org/Bodacious/factory_grabber)
