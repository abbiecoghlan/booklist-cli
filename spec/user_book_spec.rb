require "spec_helper"
require_relative '../lib/models/user'
require_relative '../lib/models/book'
require_relative '../lib/models/user_book'


RSpec.describe UserBook, :type => :model do
  
    before(:context) do
        @ann = User.create(username: "Ann")
        @last_stop = Book.create(title: "One Last Stop", publishing_company: "unknown", author: "Casey McQuiston")
        @little_fires = Book.create(title:"Little Fires Everywhere", author: "Celeste NG", publishing_company: "unknown")
        @ann.add_to_collection(@last_stop.id)
        @ann.add_to_collection(@little_fires.id)
    end

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

    describe ".my_books" do 
        it "prints all of the user books for a specified user" do
            expect{ UserBook.my_books(@ann.id) }.to output(a_string_including("You have #{@ann.books.count} books in your collection")).to_stdout
            expect{ UserBook.my_books(@ann.id) }.to output(a_string_including("#{@ann.books.first.title}")).to_stdout

        end 
    end 

    after(:context) do
        UserBook.find_by(user_id: @ann.id, book_id: @last_stop.id).destroy
        UserBook.find_by(user_id: @ann.id, book_id: @little_fires.id).destroy
        @ann.destroy
        @last_stop.destroy
        @little_fires.destroy
    end


end