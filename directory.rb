@students = []

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def show_students
  print_header
  print_students_list(@students)
  print_footer(@students)
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  @students = []                      # create an empty array
  name = STDIN.gets.gsub(/\n/, "")   # get the first name
  # while the name is not empty, repeat this code
  keys = [:cohort, :hobby, :country]
  until name.empty? do
    person = Hash.new { |this_hash, key| this_hash[key] = "missing" }
    person[:name] = name
    keys.each do |key|
      person[key] = ask(key)
      person[key] = "missing" if person[key] == :""
    end
    @students << person
    puts person
    change_response
    puts "You have added #{@students.count} student#{"s" if @students.count > 1}. Type in another name to add or press return to proceed"
    name = STDIN.gets.gsub(/\n/, "")
  end

  @students
end

def ask(keys)
  puts "Please insert a value for the person's #{keys}"
  response = STDIN.gets.gsub(/\n/, '').to_sym
  response
end

def change_response
  puts "Do you want to change any details for this student? Type name, cohort, hobby, country, or return to continue"
  response = gets.gsub(/\n/, "")

  until response.empty? do
    puts "What would you like the new response for #{response} to be?"
    hash = @students.find { |h| h[response.to_sym] }
    puts "Your new list is #{hash}"
    new_resp = gets.gsub(/\n/, "")
    hash[response.to_sym] = new_resp.to_sym
    puts "Would you like to change anything else? (name, cohort, hobby, country, or return to exit)"
    response = gets.gsub(/\n/, "")
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

# @students = [
#   {name: "Dr. Hannibal Lecter", cohort: :july},
#   {name: "Darth Vader", cohort: :july, hobby: :cricket, country: :DeathStar},
#   {name: "Nurse Ratched", cohort: :july},
#   {name: "Michael Corleone", cohort: :november},
#   {name: "Alex DeLarge", cohort: :july},
#   {name: "The Wicked Witch of the West", cohort: :july},
#   {name: "Terminator", cohort: :june},
#   {name: "Freddy Krueger", cohort: :july},
#   {name: "The Joker", cohort: :july},
#   {name: "Joffrey Baratheon", cohort: :july},
#   {name: "Norman Bates", cohort: :july},
#   {name: "Mr Killgrave", cohort: :july}
# ]

def print_students_list(students)
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

def save_students
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:hobby], student[:country]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
  puts "Student list has been saved to the databse"
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort, hobby, country = line.chomp.split(',')
    @students << {name: name, cohort: cohort, hobby: hobby, country: country}
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  return load_students("students.csv") if filename.nil? # REMOVE load_students () to revert to old v
  if File.exist?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end

try_load_students
interactive_menu
