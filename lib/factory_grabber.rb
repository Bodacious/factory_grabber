# load active support if not in Rails
require "activesupport" unless defined?(ActiveSupport::Inflector)
require "factory_girl"
module FactoryGrabber
  
  class NotANumberError < NoMethodError;end
  
  module Grab
    
    # numbers 1 to 9
    UNITS =  {
      "one"       => 1, 
      "two"       => 2, 
      "three"     => 3, 
      "four"      => 4, 
      "five"      => 5, 
      "six"       => 6, 
      "seven"     => 7,
      "eight"     => 8,
      "nine"      => 9}

    # numbers 10 to 19
    TEENS = {
      "ten"       => 10,
      "eleven"    => 11,
      "twelve"    => 12,
      "thirteen"  => 13,
      "fourteen"  => 14,
      "fifteen"   => 15,
      "sixteen"   => 16,
      "seventeen" => 17,
      "eighteen"  => 18,
      "nineteen"  => 19}

    # tens from 20 to 90
    TENS = {
      "twenty"  => 20,
      "thirty"  => 30,
      "forty"   => 40,
      "fifty"   => 50,
      "sixty"   => 60,
      "seventy" => 70,
      "eighty"  => 80,
      "ninety"  => 90}

    # define an empty hash
    ALL_NUMBERS = {}

    # add each number between 1 and 19 to ALL_NUMBERS
    UNITS.merge(TEENS).each { |name, value| ALL_NUMBERS[name] = value }

    TENS.each do |name, value|
      # add each ten from 20 to 90 to ALL_NUMBERS
      ALL_NUMBERS[name] = value
      # add each remaining number to ALL_NUMBERS
      UNITS.each { |unit_name, unit_value| ALL_NUMBERS["#{name}_#{unit_name}"] = value + unit_value }
    end


    # remove unnecessary methods from Grab class 
    instance_methods.each do |m| 
      undef_method m unless m.to_s =~ /method_missing|respond_to?|^__/ 
    end

    # add singleton class methods
    class << self

      # methods called to Grab are not really methods, they're ghost methods. 
      # If method_missing cannot identify the number and the factory to be created it will pass
      # this up the chain to Object. @name is the method name called (symbol) and options is the hash of
      # options passed to the method.
      def method_missing(name, options = {})
        @options = options
        @parts_in_name = name.to_s.split("_")
        
        # replace 'a' or 'an' with 'one'
        if @parts_in_name.first == "a" || @parts_in_name.first == "an"
          @parts_in_name.delete_at(0)
          @parts_in_name.unshift("one")
        end
        # rejoins the name with 'a' and 'an' replaced with 'one'
        @name = @parts_in_name.join("_")

        # create new records if there is not a sufficient amount in the database
        required_records ? required_records.times { create_factory } : nil
        
        # find and return the desired records
        if number.to_i > 1
          klass_name_constant.all(:conditions => @options, :limit => number)
        else
          klass_name_constant.first(:conditions => @options)
        end
      end

      private

      # returns the number part of the method name eg. nineteen
      def number_name
        @number_name = if UNITS.include?(@parts_in_name.first) || TEENS.include?(@parts_in_name.first)
          @parts_in_name.first
        elsif TENS.include?(@parts_in_name.first)
          UNITS.include?(@parts_in_name[1]) ? @parts_in_name[0..1].join("_") : @parts_in_name.first
        end
      end
      
      # returns the number as an integer
      def number
        @number = ALL_NUMBERS[number_name]
        raise NotANumberError, "#{@name} contains an invalid number" unless @number
        @number
      end
      
      # returns the klass name of the 
      def klass_name
        @name.to_s.scan(/#{number_name}_(.+)/)
        ActiveSupport::Inflector.singularize($1)
      end
      
      # returns the name of the factory as a symbol.
      # Eg. Grab.four_hippos (would return :hippo)
      def klass_name_symbol
        klass_name.to_sym
      end

      # returns the name of the factory as a Constant.
      # Eg. Grab.four_hippos (would return :hippo)      
      def klass_name_constant
        klass_name.classify.constantize
      end
      
      # TODO rewrite this to accept various factory gems
      def create_factory
        Factory klass_name_symbol, @options
      end

      # returns the number of records required minus the number of records available. If there are enough
      # records already it will return nil (so we can call <tt>required_records ? do_this : do_that</tt> )
      def required_records
        result = (number - number_of_existing_records)
        result > 0 ? result : nil
      end

      # finds the number appropriate records already in the database.
      # if klass_name_constant is not a recognised class then this returns 0
      def number_of_existing_records
        return 0 unless defined?(klass_name_constant)
        klass_name_constant.all(:conditions => @options).count
      end

    end

  end

end
include FactoryGrabber
