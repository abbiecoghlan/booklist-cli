class UserBook < ActiveRecord::Base 
    belongs_to :book
    belongs_to :user

    def self.my_books(user_id)
        books = UserBook.all.select {|user_book| user_book.user_id == user_id}
        puts "Your Reading List"
        books.each_with_index do |user_book, index| 
            puts "#{index + 1})"
            puts "Title: #{user_book.book.title}"
            puts "Author: #{user_book.book.author}" 
            puts "Publishing Company: #{user_book.book.publishing_company}" + ("\n\n")
            sleep 1
        end 

    end 

end