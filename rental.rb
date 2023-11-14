# rental.rb

class Rental
  attr_accessor :id, :date, :book, :person

  def initialize(id, date, book, person)
    @id = id
    @date = date
    @book = book
    @person = person
    person.rentals << self unless person.nil?
  end
end
