def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []

  # get the first name
  name = gets.gsub(/\n/, "")
  # while the name is not empty, repeat this code

  def ask(keys)
    puts "Please insert a value for the person's #{keys}"
    response = gets.gsub(/\n/, '').to_sym
    response
  end

  def change_response
    puts "Do you want to change any details for this student? Type name, cohort, hobby, height, or return to continue"
    response = gets.gsub(/\n/, "")

    until response.empty? do
      puts "What would you like the new response for #{response} to be?"
      hash = students.find { |h| h[response.to_sym] }
      puts "Your new list is #{hash}"
      new_resp = gets.gsub(/\n/, "")
      hash[response.to_sym] = new_resp.to_sym
      puts "Would you like to change anything else? (name, cohort, hobby, country, or return to exit)"
      response = gets.gsub(/\n/, "")
    end

  end

  keys = [:cohort, :hobby, :country]

  until name.empty? do
    person = Hash.new { |this_hash, key| this_hash[key] = "missing" }
    person[:name] = name
    keys.each do |key|
      person[key] = ask(key)
      person[key] = "missing" if person[key] == :""
    end
    students << person

    change_response

    puts "Now we have #{students.count} student#{"s" if students.count > 1}"
    # get another name from the user
    name = gets.gsub(/\n/, "")
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
  {name: "Darth Vader", cohort: :july, hobby: :cricket, country: :DeathStar},
  {name: "Nurse Ratched", cohort: :july},
  {name: "Michael Corleone", cohort: :november},
  {name: "Alex DeLarge", cohort: :july},
  {name: "The Wicked Witch of the West", cohort: :july},
  {name: "Terminator", cohort: :june},
  {name: "Freddy Krueger", cohort: :july},
  {name: "The Joker", cohort: :july},
  {name: "Joffrey Baratheon", cohort: :july},
  {name: "Norman Bates", cohort: :july},
  {name: "Mr Killgrave", cohort: :july}
]

def print(students)

  students = students.group_by {|hash| hash[:cohort]}.values
  students.each do |student|
    student.each_with_index do |s, index|
      if s[:name].to_s.length < 15
        puts "#{index+1}. #{s[:name].to_s.center(24, '-')} (#{s[:cohort]} cohort, hobby is #{s[:hobby]}, from #{s[:country]})"
      end
    end
    puts "\n"
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end


students = input_students
print_header
print(students)
print_footer(students)
