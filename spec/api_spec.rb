require "spec_helper"
require_relative '../lib/models/user'
require_relative '../lib/models/book'
require_relative '../lib/models/user_book'
require_relative '../lib/cli'
require_relative '../lib/api'


RSpec.describe API do

    describe ".input_is_valid?" do
        it "should return false when the search term has more than 4 numbers" do
            expect(API.input_is_valid?("123456")).to eq(false)
        end 
        it "should return true when the search term has less than 5 numbers" do
            expect(API.input_is_valid?("1234")).to eq(true)
        end 
    end

    describe ".send_query" do
        it "should return results" do
            expect(API.send_query("Samantha Irby")).to_not be(nil)
        end 
        it "should return false if the user inputs invalid url symbols" do 
            expect(API.send_query("*()&*(&^%$#@$%^&*()_+)*(&^%$#@%^")).to be(false)
        end 

    end


end