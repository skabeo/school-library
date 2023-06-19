require './person'
# Teacher class demonstrating the inheritance principle
class Teacher < Person
  def initialize(specialization, name = 'Unknown', age = 0, parent_permission: true)
    super(name, age, parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
