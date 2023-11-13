# book_manager.rb

class BookManager
  attr_accessor :all_books

  def initialize
    @all_books = []
  end

  def list_books
    @all_books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def add_book(book)
    @all_books.push(book)
  end

  def create_book(title, author)
    book = Book.new(title, author)
    add_book(book)
    puts 'Book created successfully'
  end
end
