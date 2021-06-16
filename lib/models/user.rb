class User < ActiveRecord::Base 
    has_many :user_books
    has_many :books, through: :user_books
    validates :username, presence: true

    def add_to_collection(book_id)
        if UserBook.find_by(book_id: book_id, user_id: self.id)
            puts "This book is already in your collection!"
            sleep 1
        else 
            UserBook.create(book_id: book_id, user_id: self.id)
            puts "Your selection was successfully added to your collection!\n\n"
            sleep 1          
        end 
    end 

end