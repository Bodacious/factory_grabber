module NumberMethods

    UNITS = {
      "one"   => 1, 
      "two"   => 2, 
      "three" => 3, 
      "four"  => 4, 
      "five"  => 5, 
      "six"   => 6, 
      "seven" => 7,
      "eight" => 8,
      "nine"  => 9}

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

    TENS = {
      "twenty"  => 20,
      "thirty"  => 30,
      "forty"   => 40,
      "fifty"   => 50,
      "sixty"   => 60,
      "seventy" => 70,
      "eighty"  => 80,
      "ninety"  => 90}
  
  # write the number methods
  def self.included base    
    base.instance_eval do

      def metaclass
        class << self
          self
        end
      end        

      def create_number_methods

        metaclass.instance_eval do

          # create a method for numbers 1 to 9
          UNITS.each do |number, value|
            define_method(number) { value }
          end

          # create a method for numbers 10 to 19
          TEENS.each do |number, value|
            define_method(number) { value }
          end

          # create a method for remaining numbers
          TENS.each do |ten_number, ten_value|
            
            define_method("#{ten_number}") {ten_value}
            
            UNITS.each do |unit_number, unit_value|

              define_method "#{ten_number}_#{unit_number}" do
                ten_value + unit_value
              end
              
            end
          end

        end
      end


    end
    base.create_number_methods
  end

end
