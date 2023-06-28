require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'
require_relative 'manage_people'
require 'json'

class App
  attr_accessor :books, :people, :rentals

  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def fetch_data(file)
    if File.exist?("data/#{file}.json")
      File.read("data/#{file}.json")
    else
      empty_file = [].to_json
      File.write("data/#{file}.json", empty_file)
      empty_file
    end
  end

  def load_data
    books = JSON.parse(fetch_data('books'))
    people = JSON.parse(fetch_data('people'))

    books.each do |book|
      @books << Book.new(book['title'], book['author'])
    end

    people.each do |person|
      @people << if person['type'] == 'Teacher'
        Teacher.new(person['age'], person['name'], person['specialization'], parent_permission: true)
      else
        Student.new(nil, person['age'], person['name'], parent_permission: person['parent_permission'])
      end
    end
  end

  def list_books
    @books.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
  end

  def list_people
    @people.each { |person| puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" }
  end

  def create_person
    selected_person_type = InputHandler.request_person_type
    case selected_person_type
    when 1
      create_student
    when 2
      create_teacher
    end
  end

  def create_book
    title, author = InputHandler.request_book_details
    puts 'New Book added'
    book = Book.new(title, author)
    @books << book
  end

  def create_rental
    selected_book, selected_person, selected_date = InputHandler.request_rental_details(@books, @people)
    return if selected_book.nil? || selected_person.nil? || selected_date.nil?

    rented = Rental.new(selected_date, @books[selected_book], @people[selected_person])
    @rentals << rented

    puts 'Book was successfully rented.'
  end

  def list_rental
    person_id = InputHandler.request_person_id
    @rentals.each do |rent|
      puts "Date: #{rent.date}, Book: #{rent.book.title} Author: #{rent.book.author}" if rent.person.id == person_id
    end
  end

  def save_books
    updated_books = []
    @books.each do |book|
      updated_books << { 'title' => book.title, 'author' => book.author }
    end
    File.write('data/books.json', JSON.pretty_generate(updated_books))
  end

  def save_people
    updated_people = []
    @people.each do |person|
      if person.instance_of?(::Teacher)
        updated_people << { 'type' => 'Teacher', 'id' => person.id, 'name' => person.name, 'age' => person.age,
                            'specialization' => person.specialization }
      elsif person.instance_of?(::Student)
        updated_people << { 'type' => 'Student', 'id' => person.id, 'name' => person.name, 'age' => person.age,
                            'parent_permission' => person.parent_permission }
      end
    end
    File.write('data/people.json', JSON.pretty_generate(updated_people))
  end

  def save_on_exit
    puts 'Thank you for using school library app'
    save_books
    save_people

    exit
  end

  def invalid_option
    puts 'Invalid option'
  end

  def options
    puts
    puts 'Please enter the number for the task you want to perform'
    puts 'choose one of the following'
    puts '1 - List all books.'
    puts '2 - List all people.'
    puts '3 - Create a person.'
    puts '4 - Create a book.'
    puts '5 - Create a rental.'
    puts '6 - List all rentals for a given person id.'
    puts '7 - Exit'
  end
end

class InputHandler
  def self.request_person_type
    print 'If you want to create a new student press (1) or press (2) for teacher? [Input the number]: '
    Integer(gets.chomp)
  end

  def self.request_book_details
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    [title, author]
  end

  def self.request_rental_details(books, people)
    if books.empty?
      puts 'No books created. Please create a book.'
      return
    elsif people.empty?
      puts 'No people created. Please create a person.'
      return
    end

    puts 'Select a book from the following list of numbers:'
    books.each_with_index { |book, index| puts "#{index}) Title: #{book.title}, Author: #{book.author}" }
    selected_book = Integer(gets.chomp)

    puts 'Select a person from the following list of numbers (not ID):'
    people.each_with_index do |person, index|
      puts "#{index}) Name: #{person.name} Age: #{person.age} ID: #{person.id}"
    end
    selected_person = Integer(gets.chomp)

    print 'Date MM/DD/YYYY: '
    selected_date = gets.chomp.to_s

    [selected_book, selected_person, selected_date]
  end

  def self.request_person_id
    print 'Enter the Person ID: '
    Integer(gets.chomp)
  end
end
