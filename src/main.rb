require_relative 'app'
require_relative 'home_page'

def main
  app = App.new
  home_page(app)
end

main
