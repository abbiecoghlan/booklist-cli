require 'httparty'
require 'pry'

URL = "https://www.googleapis.com/books/v1/volumes?q="


class API

    def self.user_input
        gets.chomp
    end 

    #to-do: add logic to catch if userinput is 
    def self.input_is_valid?(search_term)
        search_term.match(/\d/) && search_term.match(/\d/).length > 4 ? false : true
    end 


    def self.send_query(search_term)
        response = HTTParty.get(URL+search_term+"&maxResults=5") rescue false
        if response && response.parsed_response
            return response.parsed_response
        else
            return false 
        end 
    end 

    def self.no_results
        puts "I'm sorry, no results were found matching your search. Please try again.\n\n"
    end 

    def self.parse_results(data)
        books = []
        data["items"].map do |result|

            publishing_company = result["volumeInfo"]["publisher"] ||= "unknown"
            title = result["volumeInfo"]["title"] ||= "unknown"

            if result["volumeInfo"]["authors"] 
                author = result["volumeInfo"]["authors"][0] ||= "unknown"
            elsif result["volumeInfo"]["author"] 
                author = result["volumeInfo"]["author"] ||= "unknown"
            else 
                author = "unknown"
            end  

            @book = Book.find_by(title: title, author: author, publishing_company: publishing_company)
            if @book
                books.push(@book)
            else 
                @book = Book.create(title: title, author: author, publishing_company: publishing_company)
                books.push(@book)
            end        
        end
        books
    end 

    def self.search
        puts 'What are you looking for?'
        search_term = self.user_input

        if !self.input_is_valid?(search_term)
            return false
        end 

        data = self.send_query(search_term)
        if data && data["items"]
            return books = self.parse_results(data)    
        else 
            self.no_results
            sleep 1
            self.search
        end 
    end 

end 