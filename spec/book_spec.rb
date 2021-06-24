require "spec_helper"
require_relative '../lib/models/user'
require_relative '../lib/models/book'
require_relative '../lib/models/user_book'


RSpec.describe Book, :type => :model do

    before(:context) do
        @last_stop = Book.create(title: "One Last Stop", publishing_company: "unknown", author: "Casey McQuiston")
        @little_fires = Book.create(title:"Little Fires Everywhere", author: "Celeste NG", publishing_company: "unknown")
    end

    describe "#title" do
        it "can have a title" do
            expect(@last_stop.title).to eq("One Last Stop")
        end
    end

    describe "#publishing_company" do
        it "can have a publishing company" do
            expect(@last_stop.publishing_company).to eq("unknown")
        end
    end

    describe "#author" do
        it "can have an author" do
            expect(@last_stop.author).to eq("Casey McQuiston")
        end
    end

    describe ".all" do
        it "knows about all book instances" do
            expect(Book.all).to include(@last_stop)
            expect(Book.all).to include(@little_fires)
        end
    end

    describe "Associations" do
        it "has many user_books" do
            t = Book.reflect_on_association(:user_books)
            expect(t.macro).to eq(:has_many)
        end 
    end

    describe ".tty_hash" do
        it "returns a hash for the ttyPrompt with author, title, and publishing co as a key and id as return value" do
            expect(@last_stop.tty_hash).to eq({"Title: One Last Stop\nAuthor: Casey McQuiston\nPublishing Company: unknown\n"=>@last_stop.id})
        end
    end

    after(:context) do
        @last_stop.destroy
        @little_fires.destroy
    end

end