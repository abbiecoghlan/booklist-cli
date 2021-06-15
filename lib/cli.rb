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
        puts "\n📚 WELCOME TO BOOK LIST 📚\n"
        sleep 2
        login_or_signup_menu
    end 

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
        when "Create Account"
            create_account
        when "Exit"
            quit
        end
    end 

    def login
       clear_screen
        puts "Please enter your Username: "
        username = user_input.chomp.downcase
        @user = User.find_by(username: username)
        if @user 
            clear_screen
            puts ("\nWelcome, #{@user.username}!")
            sleep 1
            main_menu
        else 
            clear_screen
            puts ("I'm sorry, I couldn't find an account with that username. Please try again, or create a new account.\n\n")
            login_or_signup_menu
        end 
    end 

    def create_account 
        clear_screen
        puts "Enter a username to sign up for Book List:"
        username = user_input

        if User.find_by(username: username.downcase)
            puts "I'm sorry, that username is taken!"
        else 
            @user = User.create(username: username.downcase)
            puts "\nWelcome, #{@user.username}!"
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
            view_books(@user)
        when "Add to Book List"
            clear_screen
            search
        when "Logout"
            logout
        when "Exit"
            quit
        end
    end 

    def view_books(user)
        puts "#{user.username}'s book collection\n\n"
            if user.books.count > 0
            clear_screen
            UserBook.my_books(user.id)
            binding.pry
            # user.my_books
            # user.print_books(user.books)
            puts ""
            main_menu
        else 
            clear_screen
            puts "Your bookshelf is currently empty.\n\n"
            main_menu
        end 
    end 

    def search
        puts 'What are you looking for?'
        data = send_query(user_input)
        if data["items"] 
            books = parse_results(data)
            book_selection(books)
        else 
            no_results
            sleep 2
            search
        end 
    end 

    def book_selection(book_array)
        prompt = TTY::Prompt.new(active_color: :blue, symbols: {marker: "📚"})
        choice = prompt.select("Please select a book to add to your reading list:", book_array.map {|book| book.tty_hash}, "Return to menu")

        if choice == "Return to menu"
            clear_screen
            main_menu
        else 
            @user.add_to_collection(choice) 
            main_menu
        end 
    end 

    # def add_to_shelf(book_id)
    #     if UserBook.find_by(book_id: book_id, user_id: @user.id)
    #         puts "This book is already in your collection!"
    #         sleep 1
    #     else 
    #         UserBook.create(book_id: book_id, user_id: @user.id)
    #         puts "Your selection was sucessfully added to your collection!\n\n"
    #         sleep 1          
    #     end 

    #     main_menu
    # end 
        
    def logout 
        clear_screen
        @user = nil
        puts "📚 WELCOME TO BOOK LIST 📚\n\n"
        sleep 1
        login_or_signup_menu
    end     
 
    def quit
        clear_screen
        puts "Goodbye!"
    end 

end 