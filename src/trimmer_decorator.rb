require_relative 'base_decorator'

class TrimmerDecorator < BaseDecorator
  def correct_name
    if @nameable.correct_name.length > 10
      @nameable.correct_name.slice(0, 10)
    else
      @Nameable.correct_name
    end
  end
end
