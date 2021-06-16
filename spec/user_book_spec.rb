require "spec_helper"


require_relative '../lib/models/user'
require_relative '../lib/models/book'
require_relative '../lib/models/user_book'


RSpec.describe UserBook, :type => :model do

  
    describe "Associations" do
        it "belongs to a user" do
            t = UserBook.reflect_on_association(:user)
            expect(t.macro).to eq(:belongs_to)
        end 
        it "belongs to a book" do
            t = UserBook.reflect_on_association(:book)
            expect(t.macro).to eq(:belongs_to)
        end 

    end



end