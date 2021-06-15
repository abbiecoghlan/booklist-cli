# Book List CLI
Book List is a simple command line application that allows users to search for books to add to a reading list. This virtual "bookshelf" allows utilizes the Google Books API to search for and return books matching user queries.


## Technology
Book List is a command line application written in Ruby. It has a SQLite database and utilizes Active Record for Object Relational Mapping. It also utilizes the Google Books API to provide book data in response to user queries. 

## Installation
1. Fork and clone this repository into your local environement
2. cd into the booklist folder from the terminal
3. run the command `bundle install`
4. run `rake launch` to launch the application

## Instructions for Use
1. Once you've followed the instructions and launched the application, follow the menu prompts to login or create an account by signing up
2. Once logged in, a user can follow prompts to view their reading list or search for a book to add to their reading list
3. You can follow the menu prompt to logout at anytime and allow another user to sign in without exiting the application.
4. If you would like to sign out and close the application, follow the menu prompt to exit.
5. After exiting, you can restart the application using the `rake launch` command in your terminal


