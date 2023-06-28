def menu(app)
  app.options
  print '>>> : '
  gets.chomp.to_i
end

def manage_selection(app, option)
  tasks = {
    1 => :list_books,
    2 => :list_people,
    3 => :create_person,
    4 => :create_book,
    5 => :create_rental,
    6 => :list_rental,
    7 => :save_on_exit,
    default: :invalid_option
  }

  selection = tasks[option] || tasks[:default]
  app.send(selection)
end

def home_page(app)
  loop do
    option = menu(app)
    manage_selection(app, option)
    puts "\n"
  end
end
