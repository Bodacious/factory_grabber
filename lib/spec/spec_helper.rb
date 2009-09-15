require "rubygems"
  
["database_setup", "user", "factories", "../factory_grabber"].each do |file|
  require "#{File.dirname(__FILE__)}/#{file}"
end

include FactoryGrabber