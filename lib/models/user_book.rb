class UserBook < ActiveRecord::Base 
    belongs_to :book
    belongs_to :user

    def self.my_books(user_id)
        books = UserBook.all.select {|user_book| user_book.user_id == user_id}

        books.each_with_index do |user_book, index| 
            puts "#{index + 1}."
            print "Title: ".bold.blue
            puts "#{user_book.book.title}"
            print "Author: ".bold.blue
            puts "#{user_book.book.author}" 
            print "Publishing Company: ".bold.blue
            puts "#{user_book.book.publishing_company}" + ("\n\n")
        end 

    end 

end