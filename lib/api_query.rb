require 'httparty'
require 'pry'

URL = "https://www.googleapis.com/books/v1/volumes?q="


def send_query(search_term)
    response = HTTParty.get(URL+search_term+"&maxResults=5")
    if response.parsed_response  
        return response.parsed_response
    else 
        return no_results
    end 

end 

def no_results
    puts "I'm sorry, no results were found matching your search. Please try again"
end 

def parse_results(data)
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