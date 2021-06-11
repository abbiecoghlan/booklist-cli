require 'pry'


class CLI

    def user_input
        gets.chomp
    end 

    def run
        #testing api_query.rb - this will be moved one menus are created
        puts 'What are you looking for?'
        send_query(user_input)
    end 


    #welcome screen

    #prompt to login or create account 

    #menu with options 
        #1. View Book List
            #User method to print and show books
        #2. Add a book
            #send_query function 
                #menu to select from the results
                #add the book or go back 
                    #create_book function returns the book
                        # @book = create_book
                        #add_to_shelf(@user.id, @book.id) function to create user_book
        #3. Logout
        #4. Exit

    


end 