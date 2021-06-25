require "spec_helper"
require_relative '../lib/models/user'
require_relative '../lib/models/book'
require_relative '../lib/models/user_book'
require_relative '../lib/cli'


RSpec.describe CLI do
    before(:context) do
        @annie = User.create(username: "annie")
    end

    describe "#greet" do
        it "should provide a description of the app" do
            expect { CLI.new.greet }.to output(a_string_including("Book List allows users to search for books to add to a reading list. This virtual 'bookshelf' utilizes the Google Books API to search for and return books matching user queries.")).to_stdout
        end 
    end

    describe "#user_input" do
        let(:input) { StringIO.new("Abbie Coghlan") }
        it "should be capture the users input" do
            $stdin = input            
            expect(CLI.new.user_input).to eq("Abbie Coghlan")
        end 
    end
    
    describe "#run" do
        let(:cli) { CLI.new }
        it "should take user to login menu" do
            expect(cli).to receive(:login_or_signup_menu)
            cli.run
        end 
    end

    describe "#login" do
    let(:cli) { CLI.new }
    let(:input) { StringIO.new("annie") }
    let(:notfound) { StringIO.new("notauser") }

        it "should login an existing user and take them to the main menu" do                       
            $stdin = input           
            expect(cli).to receive(:main_menu)            
            cli.login
        end
        it "should redirect a user that does not exist and them to the main menu" do                       
            $stdin = notfound           
            expect(cli).to receive(:login_or_signup_menu)            
            cli.login
        end
    end

    after(:context) do
        @annie.destroy
    end


end

