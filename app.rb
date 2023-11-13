require './person'
require './student'
require './teacher'
require './classroom'
require './book'

class InputHandler
  def self.get_string(prompt)
    print prompt
    gets.chomp
  end

  def self.get_integer(prompt)
    print prompt
    gets.chomp.to_i
  end

  def self.get_boolean(prompt)
    print prompt
    gets.chomp.downcase == 'y'
  end
end

class PersonInputHandler
  def self.create_person
    type = InputHandler.get_integer('Do you want to create student (1) or a teacher (2)? [Input number]: ')
    age = InputHandler.get_integer('Age: ')
    name = InputHandler.get_string('Name: ')

    if type == 1
      permission = InputHandler.get_boolean('Has parent permission? [Y/N]: ')
      return Student.new(age, name, parent_permission: permission) # Adjusted here
    else
      specialization = InputHandler.get_string('Specialization: ')
      return Teacher.new(age, name, specialization)
    end
  end
end

class BookInputHandler
  def self.create_book
    title = InputHandler.get_string('Title: ')
    author = InputHandler.get_string('Author: ')
    return Book.new(title, author)
  end
end

class RentalInputHandler
  def self.create_rental(all_books, all_persons)
    puts 'Select a book from the following list by number'
    all_books.each_with_index do |book, index|
      puts "#{index}) Title: #{book.title}, Author: #{book.author}"
    end
    book_index = InputHandler.get_integer('')

    puts 'Select person from the following list by number'
    all_persons.each_with_index do |person, index|
      person_type = person.instance_of?(Student) ? 'Student' : 'Teacher'
      puts "#{index})[#{person_type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_index = InputHandler.get_integer('')

    date = InputHandler.get_string('Date: ')
    return all_books[book_index], all_persons[person_index], date
  end

  def self.get_rental_person_id
    InputHandler.get_integer('ID of person: ')
  end
end

class App
  def initialize(person_manager, book_manager, rental_manager)
    @person_manager = person_manager
    @book_manager = book_manager
    @rental_manager = rental_manager
  end

  def execute_option(number)
    case number
    when 1
      @book_manager.list_books
    when 2
      @person_manager.list_persons
    when 3
      create_person
    when 4
      create_book
    when 5
      create_rental(@book_manager.all_books, @person_manager.all_persons)
    when 6
      get_rental(@person_manager.all_persons)
    else
      puts 'Enter valid number'
      main
    end
  end

  def create_person
    person = PersonInputHandler.create_person
    if person.is_a?(Student)
      student_permission = InputHandler.get_boolean('Has parent permission? [Y/N]: ')
      person = Student.new(person.age, person.name, parent_permission: student_permission)
    end

    @person_manager.add_person(person)
    puts 'Person created successfully'
  end

  def create_book
    book = BookInputHandler.create_book
    @book_manager.add_book(book)
    puts 'Book created successfully'
  end

  def create_rental(all_books, all_persons)
    book, person, date = RentalInputHandler.create_rental(all_books, all_persons)
    @rental_manager.create_rental(person.id, date, book, person)
    puts 'Rental created successfully'
  end

  def get_rental(all_persons)
    id = RentalInputHandler.get_rental_person_id
    rental = @rental_manager.get_rental(id)

    if rental.nil?
      puts 'Rental not found.'
    else
      puts 'Rentals:'
      puts "Date: #{rental.date}, Book: \"#{rental.book.title}\" by #{rental.book.author}"
    end
  end
end
