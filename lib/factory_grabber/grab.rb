class Grab

  require "activesupport" unless defined?(ActiveSupport::Inflector)
  require "number_methods"
  require "factory_girl"
  include NumberMethods

  # create a blank slate
  instance_methods.each do |m| 
    undef_method m unless m.to_s =~ /method_missing|respond_to?|^__/ 
  end
  
  class << self
    
    def method_missing(name, options = {})
      @options = options
      # split the method into array eg. ["forty", "four", "mexicans"]
      parts = name.to_s.split("_")
      # remove the model name from the method name
      parts.pop
      # joins the remaining strings eg. ["forty_four"]
      @number = parts.join("_")
    
      # send to superclass if not a valid number
      unless respond_to?(@number)
        super(name, options)
      end
    

      # class name as symbol
      @symbol = ActiveSupport::Inflector.singularize(name.to_s.split("_").last.to_s).to_sym

      # class name as constant
      @klass = @symbol.to_s.classify.constantize      

      
      # number as an integer value
      @no = self.send(@number)
    
      # create extra records if neccessary
      if required_records
        required_records.times { Factory(@symbol, options) }
      end
    
      # return the required records
      @klass.all(:conditions => options, :limit => @no)
    end
  
  private
  
    def required_records
      res = @no - no_of_records
      res > 0 ? res : nil
    end
  
    def no_of_records
      valid_records.count
    end


    def valid_records
      @klass.all(:conditions => @options)
    end

  end
  
end