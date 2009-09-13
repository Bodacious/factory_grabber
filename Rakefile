require "rubygems"
require "rake"
require "echoe"

Echoe.new("factory_grabber", "0.1.0") do |p|
  p.description              = "Grab or create factories for faster Functional/Integration testing"
  p.url                      = "http://github.com/gavinM/factory_grabber"
  p.author                   = "Gavin Morrice"
  p.email                    = "gavin@handyrailstips.com"
  p.ignore_pattern           = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }