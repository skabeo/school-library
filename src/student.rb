require './person'
# Student class demonstrating the inheritance principle
class Student < Person
  def initialize(classrooms, name = 'Unknown', age = 0, parent_permission: true)
    super(name, age, parent_permission)
    @classrooms = classrooms
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end
