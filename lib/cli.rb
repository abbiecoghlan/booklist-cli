require 'pry'
require 'ruby2d'


class CLI

    def user_input
        gets.chomp
    end 

    def clear_screen
        system "clear"
    end

    def run
        puts "Welcome to BookList!"
        sleep 1
        clear_screen
        login_or_signup_menu
    end 

    #Prints welcome message, prompt to sign up or login
    def login_or_signup_menu
        prompt = TTY::Prompt.new(active_color: :blue, symbols: {marker: "📚"})
        my_menu = prompt.select("Please select from the following options:") do |menu|
            menu.choice 'Login'
            menu.choice 'Create Account'
            menu.choice 'Exit' 
        end 
        
        case my_menu
        when "Login" 
            login
        when "Create Acount"
            create_account
        when "Exit"
            quit
        end
    end 

    def login
        "Please enter your Username: "
        username = user_input.chomp.downcase
        @user = User.find_by(username: username)
        if @user 
            puts ("Welcome, #{@user.username}")
            main_menu
        else 
            puts ("I'm sorry, I couldn't find an account with that username. Please try again, or create a new account.")
            login_or_signup_menu
        end 
    end 

    def create_account 
        puts "Enter a username to sign up for Book List!"
        username = user_input
        
        if User.find_by(username: username.downcase)
            puts "I'm sorry, that username is taken!"
        else 
            @user = User.create(username= username.downcase)
            puts "Welcome, #{@user.username}!"
            sleep 1
            main_menu
        end 
    end 

    def main_menu
        prompt = TTY::Prompt.new(active_color: :blue, symbols: {marker: "📚"})
        my_menu = prompt.select("Please select from the following options:") do |menu|
            menu.choice 'View Book List'
            menu.choice 'Add to Book List'
            menu.choice 'Logout'
            menu.choice 'Exit' 
        end 
        
        case my_menu
        when "View Book List" 
            @user.my_books
            main_menu
        when "Add to Book List"
            search
        when "Logout"
            logout
        when "Exit"
            quit
        end
    end 

    

    def search
        puts 'What are you looking for?'
        send_query(user_input)
        #menu to select from the results
        #add the book or go back 
    end 


        #create_book function returns the book
            # @book = create_book
            #add_to_shelf(@user.id, @book.id) function to create user_book
        

    def logout 
    end     
 

    def quit
        clear_screen
        puts "Goodbye!"
    end 



end 