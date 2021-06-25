require 'pry'


class CLI

    def user_input
        gets.chomp
    end 

    def clear_screen
        system "clear"
    end

    def greet
        puts "\n📚 WELCOME TO BOOK LIST 📚".bold.blue
        puts "Book List allows users to search for books to add to a reading list. This virtual 'bookshelf' utilizes the Google Books API to search for and return books matching user queries.\n\n".italic
    end 

    def run
        greet
        sleep 2
        login_or_signup_menu
    end 

    def login_or_signup_menu
        prompt = TTY::Prompt.new(active_color: :bright_blue, symbols: {marker: "📚"})
        my_menu = prompt.select("Please select from the following options:") do |menu|
            menu.choice 'Login'
            menu.choice 'Create Account'
            menu.choice 'Exit' 
        end 
        
        case my_menu
        when "Login" 
            clear_screen
            login
        when "Create Account"
            clear_screen
            create_account
        when "Exit"
            quit
        end
    end 

    def login
        puts "Please enter your Username: "
        username = user_input.chomp.downcase
        @user = User.find_user(username)

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
        puts "Enter a username to sign up for Book List:"
        username = user_input.downcase
        validate_username(username)
        @user = User.create(username: username)

        clear_screen
        puts "\nWelcome, #{@user.username}!\n"
        sleep 1
        main_menu
    end 


    def validate_username(username)
        if username.length < 1 
            clear_screen
            puts "Username cannot be blank. Please try again!\n\n"
            create_account
        elsif User.find_by(username: username)
            clear_screen
            puts "I'm sorry, that username is taken!\n\n"
            sleep 1
            create_account      
        end 

    end 

    def main_menu
        prompt = TTY::Prompt.new(active_color: :bright_blue, symbols: {marker: "📚"})
        my_menu = prompt.select("Please select from the following options:") do |menu|
            menu.choice 'View Reading List'
            menu.choice 'Add to Reading List'
            menu.choice 'Logout'
            menu.choice 'Exit' 
        end 
        
        case my_menu
        when "View Reading List"
            view_books(@user)
        when "Add to Reading List"
            clear_screen
            books = API.search
            book_selection(books)
        when "Logout"
            logout
        when "Exit"
            quit
        end
    end 

    def view_books(user)
        if user.books.count > 0
            clear_screen
            puts "#{user.username}'s book collection\n\n"
            UserBook.my_books(user.id)
            puts ""
            main_menu
        else 
            clear_screen
            puts "Your reading list is currently empty.\n\n"
            main_menu
        end 
    end 


    def book_selection(book_array)
        prompt = TTY::Prompt.new(active_color: :bright_blue, symbols: {marker: "📚"})
        choice = prompt.select("Please select a book to add to your reading list:", book_array.map {|book| book.tty_hash}, "Return to menu".italic.red)

        if choice == "Return to menu".italic.red
            clear_screen
            main_menu
        else 
            clear_screen
            @user.add_to_collection(choice) 
            main_menu
        end 
    end 

    def logout 
        clear_screen
        @user = nil
        puts "📚 WELCOME TO BOOK LIST 📚".bold.blue
        puts "Book List allows users to search for books to add to a reading list. This virtual 'bookshelf' utilizes the Google Books API to search for and return books matching user queries.\n\n"
        sleep 1
        login_or_signup_menu
    end     
 
    def quit
        clear_screen
        puts "Goodbye!"
    end 

end 