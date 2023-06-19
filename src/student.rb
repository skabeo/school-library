require './person'

# Student class demonstrating the inheritance principle
class Student < Person
  def initialize(age, classrooms, name: 'Unknown', parent_permission: true)
    super(age, name, parent_permission)
    @classrooms = classrooms
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end
