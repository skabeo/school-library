def create_teacher
  print "teacher's specialization: "
  specialization = gets.chomp
  print "teacher's age: "
  age = gets.chomp
  print "teacher's name: "
  name = gets.chomp
  teacher = Teacher.new(age, name, specialization, parent_permission: true)
  @people << teacher
  puts 'You have successfully registered a Teacher'
end

def create_student
  print 'Age: '
  age = Integer(gets.chomp)
  print 'Name: '
  name = gets.chomp
  print 'Has parent permission? [Y/N]'
  parent_permission = gets.chomp.downcase

  case parent_permission
  when 'n'
    student = Student.new(nil, age, name, parent_permission: false)
    @people << student
  when 'y'
    student = Student.new(nil, age, name, parent_permission: true)
    @people << student
  else
    'You have entered an invalid option'
  end

  puts 'You have successfully registered a Student'
end
