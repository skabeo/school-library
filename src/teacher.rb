require_relative 'person'
# Teacher class demonstrating the inheritance principle
class Teacher < Person
  attr_accessor :specialization

  def initialize(specialization, age, name)
    super(age, name)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
