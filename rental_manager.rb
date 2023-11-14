# rental_manager.rb

require_relative 'rental' # Adjust the path accordingly based on your project structure

class RentalManager
  attr_accessor :all_rentals

  def initialize
    @all_rentals = []
  end

  def create_rental(id, date, book, person)
    rental = Rental.new(id, date, book, person)
    @all_rentals.push(rental)
  end

  def find_rental_by_id(id)
    @all_rentals.find { |rental| rental.id == id }
  end

  def get_rental(id)
    find_rental_by_id(id)
  end
end
