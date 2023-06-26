require_relative 'person'

# Student class demonstrating the inheritance principle
class Student < Person
  attr_accessor :classrooms

  def initialize(age, name, parent_permission)
    super(name, parent_permission: parent_permission)
    @classrooms = classrooms
  end

  def play_hooky
    '¯\(ツ)/¯'
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end
