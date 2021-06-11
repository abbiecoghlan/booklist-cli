require 'httparty'
require 'pry'

URL = "https://www.googleapis.com/books/v1/volumes?q="



def send_query(search_term)
    response = HTTParty.get(URL+search_term+"&maxResults=5")
    data = response.parsed_response
     
    #to-do: decide how to parse the results below to present for selection and then to persist to db
    data["items"].map do |result| 
        title = result["volumeInfo"]["title"]
        #sometimes more than one author, sometimes not - will need to add logic 
        author = puts result["volumeInfo"]["authors"][0] 
        publisher = result["volumeInfo"]["publisher"]
    end

     
end 

