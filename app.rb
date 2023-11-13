require './person'
require './student'
require './teacher'
require './classroom'
require './rental'
require './book'

class InputManager
  def self.get_age
    print 'Age: '
    gets.chomp.to_i
  end

  def self.get_name
    print 'Name: '
    gets.chomp
  end

  def self.get_permission
    print 'Has parent permission? [Y/N]: '
    gets.chomp
  end

  def self.get_specialization
    print 'Specialization: '
    gets.chomp
  end

  def self.get_book_choice(books)
    puts 'Select a book from the following list by number'
    books.each_with_index do |book, index|
      puts "#{index}) Title: #{book.title}, Author: #{book.author}"
    end
    gets.chomp.to_i
  end

  def self.get_person_choice(persons)
    puts 'Select person from the following list by number'
    persons.each_with_index do |person, index|
      person_type = person.instance_of?(Student) ? 'Student' : 'Teacher'
      puts "#{index})[#{person_type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    gets.chomp.to_i
  end

  def self.get_date
    print 'Date: '
    gets.chomp
  end
end

class App
  def initialize
    @all_books = []
    @all_persons = []
  end

  def create_book(title, author)
    book = Book.new(title, author)
    @all_books.push(book)
    puts 'Book created successfully'
  end

  def create_person(person_code)
    if person_code == 1
      create_student
    elsif person_code == 2
      create_teacher
    else
      puts 'Enter valid number'
      call(3)
    end
    puts 'Person created successfully'
  end

  def create_student
    age = InputManager.get_age
    name = InputManager.get_name
    permission = InputManager.get_permission
    permission_values = %w[n N]
    person = Student.new(age, name, permission_values.include?(permission))
    @all_persons.push(person)
  end

  def create_teacher
    age = InputManager.get_age
    name = InputManager.get_name
    specialization = InputManager.get_specialization
    person = Teacher.new(age, specialization, name)
    @all_persons.push(person)
  end

  def list_books
    puts @all_books.inspect
    @all_books.each do |book|
      puts "Title: \"#{book.title}\", Author: #{book.author}"
    end
  end

  def list_persons
    @all_persons.each do |person|
      person_type = person.instance_of?(Student) ? 'Student' : 'Teacher'
      puts "[#{person_type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_rental
    book_index = InputManager.get_book_choice(@all_books)
    person_index = InputManager.get_person_choice(@all_persons)
    date = InputManager.get_date
    Rental.new(date, @all_books[book_index], @all_persons[person_index])
    puts 'Rental created successfully'
  end

  def get_rental(id)
    person = @all_persons.find { |per| per.id == id }
    puts 'Rentals:'
    person.rentals.each do |rental|
      puts "Date: #{rental.date}, Book: \"#{rental.book.title}\" by #{rental.book.author}"
    end
  end
end
