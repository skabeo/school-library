require_relative 'nameable'

class BaseDecorator < Nameable
  attr_accessor :nameable
  
  def intialize(nameable)
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end
