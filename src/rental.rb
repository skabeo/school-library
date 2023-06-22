class Rental
  attr_accessor :date, :book, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
    @book.add_rental(self)
    @person.add_rental(self)
  end
end
