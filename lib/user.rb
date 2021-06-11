class User < ActiveRecord::Base 
    has_many :user_books
    has_many :books, through: :user_books

    def my_books
        ##iterate over all the user's books

        self.books.each_with_index do |book, index| 
            puts "Book #{index + 1}:"
            puts "Title: #{book.title}"
            puts "Author: #{book.author}" 
            puts "Publishing Company: #{book.publishing_company}"
        end 
        
    end 

end