class User < ActiveRecord::Base 
    has_many :user_books
    has_many :books, through: :user_books

    def my_books
        ##iterate over all the user's books
        debugger 
        # self.books.map |book| do 
        
        #     puts book.title
        #     puts book.author
        #     puts book.publishing_company
        # end 
        
    end 

end