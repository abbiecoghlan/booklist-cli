require "spec_helper"


require_relative '../lib/models/user'
require_relative '../lib/models/book'
require_relative '../lib/models/user_book'


RSpec.describe User, :type => :model do

    before(:context) do
        @lisa = User.create(username: "lisaforthewin")
        @ann = User.create(username: "Ann")
        @last_stop = Book.create(title: "One Last Stop", publishing_company: "unknown", author: "Casey McQuiston")
        @little_fires = Book.create(title:"Little Fires Everywhere", author: "Celeste NG", publishing_company: "unknown")
        @ann.add_to_collection(@last_stop.id)
    end


    describe "#username" do
        it "has a username" do
            expect(@lisa.username).to eq("lisaforthewin")
        end
    end

    describe "validation" do
        it "is not valid without a username" do
            abbie = User.new(username: "")
            expect(abbie).to_not be_valid
        end
    end

    describe ".all" do
        it "knows about all user instances" do
            expect(User.all).to include(@ann)
            expect(User.all).to include(@lisa)
        end
    end

    describe "Associations" do
        it "has many user_books" do
            t = User.reflect_on_association(:user_books)
            expect(t.macro).to eq(:has_many)
        end 
    end

    describe "Validations" do
        it "has a username" do 
            user = User.new(username: "")
            user.valid?
            expect(user.errors[:username].size).to eq(1)
        end 
    end

    describe ".add_to_collection" do
        it "adds a book to a user's reading list" do
            expect(@ann.books).to include(@last_stop)
            expect(@ann.books).not_to include(@little_fires)
        end
    end

    after(:context) do
        UserBook.find_by(user_id: @ann.id, book_id: @last_stop.id).destroy
        @lisa.destroy
        @ann.destroy
        @last_stop.destroy
        @little_fires.destroy
    end

end
