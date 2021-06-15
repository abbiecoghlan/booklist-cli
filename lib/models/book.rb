class Book < ActiveRecord::Base 
    has_many :user_books
    has_many :users, through: :user_books

    def tty_hash
        { "Title: #{self.title}" + ("\n") + "Author: #{self.author}" + ("\n") + "Publishing Company: #{self.publishing_company}" + ("\n")   => self.id }
    end 

    

end