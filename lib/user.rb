class User < ActiveRecord::Base 
    has_many :user_books
    has_many :books, through: :user_books

    def booklist
        ##iterate over all the user's books
        self.books
    end 

end