def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :july}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end


#first we print the list of students
def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

students = [
  {name: "Dr. Hannibal Lecter", cohort: :july},
  {name: "Darth Vader", cohort: :july},
  {name: "Nurse Ratched", cohort: :july},
  {name: "Michael Corleone", cohort: :july},
  {name: "Alex DeLarge", cohort: :july},
  {name: "The Wicked Witch of the West", cohort: :july},
  {name: "Terminator", cohort: :july},
  {name: "Freddy Krueger", cohort: :july},
  {name: "The Joker", cohort: :july},
  {name: "Joffrey Baratheon", cohort: :july},
  {name: "Norman Bates", cohort: :july},
  {name: "Mr Killgrave", cohort: :july}
]

def print(students)
  students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end



students = input_students
print_header
print(students)
print_footer(students)
