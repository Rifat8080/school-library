require 'json'

module BooksPersistence
  def store_books(books)
    data = books.map { |book| { title: book.title, author: book.author } }
    File.write('./books.json', JSON.generate(data))
  end

  def load_books
    data = []
    file_path = './books.json'

    File.open(file_path, 'a+') do |file|
      file.seek(0)
      content = file.read
      content = '[]' if content.empty?

      JSON.parse(content).each do |book|
        data << Book.new(book['title'], book['author'], book['id'])
      end
    end

    data
  end
end
