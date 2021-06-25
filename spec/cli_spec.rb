require "spec_helper"
require_relative '../lib/models/user'
require_relative '../lib/models/book'
require_relative '../lib/models/user_book'
require_relative '../lib/cli'


RSpec.describe CLI do
    
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

    #to-do: add more tests for the CLI functions 


end

