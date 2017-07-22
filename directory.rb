puts File.read($0)

require 'csv'
@students_csv = CSV.read('students.csv')

puts "Running #{__FILE__}..."

@students = []
@load_status = 0

def print_menu
  puts '1. Input the students'
  puts '2. Show the students'
  puts '3. Save the list to students.csv'
  puts '4. Load the list from students.csv'
  puts '9. Exit'
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
    when '1'
      puts "You have chosen to input a student\n\n"
      input_students
    when '2'
      puts "\n\nShowing students...\n\n"
      show_students
    when '3'
      save_students
    when '4'
      load_students
    when '9'
      puts 'Exiting the student directory program.'
      puts 'See you soon!'.center(30, '-')
      exit
    else
      puts "Invalid input, try again\n\n"
  end
end

def input_students
  puts 'Please enter the names of the students'
  puts 'To finish, just hit return twice'
  name = STDIN.gets.gsub(/\n/, "")
  keys = [:cohort, :hobby, :country]
  until name.empty? do
    person = Hash.new { |this_hash, key| this_hash[key] = 'missing'}
    person[:name] = name
    keys.each do |key|
      person[key] = ask(key)
      person[key] = 'missing' if person[key] == :""
    end
    @students << person
    puts "You have added #{person[:name]} to the list, in the #{person[:cohort]} cohort\n\n"
    change_response
    puts "You have added #{@students.count} student#{"s" if @students.count > 1}. Type in another name to add or press return to proceed"
    name = STDIN.gets.gsub(/\n/, "")
  end
  @students
end

def ask(keys)
  puts "Please insert a value for the person's #{keys}"
  STDIN.gets.gsub(/\n/, '').to_sym
end

def change_response
  puts 'Do you want to change any details for this student? Type name, cohort, hobby, country, or return to continue'
  response = gets.gsub(/\n/, "")

  until response.empty? do
    puts "What would you like the new response for #{response} to be?"
    hash = @students.find { |h| h[response.to_sym] }
    new_resp = gets.gsub(/\n/, "")
    hash[response.to_sym] = new_resp.to_sym
    puts "Your new list is #{hash}\n\n"
    puts 'Would you like to change anything else? (name, cohort, hobby, country, or return to exit)'
    response = gets.gsub(/\n/, "")
  end
end

def print_header
  puts 'The students of Villains Academy'
  puts '-------------'
end

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
  puts 'What file would you like to save these students to?'
  filename = gets.chomp
  if File.exist?(filename)
    puts "File #{filename} found\n\n"
  else
    puts "File not found...would you like to crete a new one? Y/n"
    answer = gets.chomp
    case answer
      when answer.downcase == "y"
        puts "creating a new file called #{filename}\n\n"
      when answer.downcase == "n"
    end
  end
  File.open(filename, "w") do |file|
    # iterate over the array of students
    @students.each do |student|
      student_data = [student[:name], student[:cohort], student[:hobby], student[:country]]
      csv_line = student_data.join(",")
      file.puts csv_line
      end
  end
  puts "#{@students.count} students have been saved to #{filename}\n\n"
end

def load_students(filename = @students_csv)
  if @load_status == 1
    puts 'Which file would you like to load the students from? Press return to skip'
    filename = gets.chomp
  end

  until filename.empty?

    # TODO - Change this into CSV. format
    if File.exist?(filename)
      puts "\n\nLoading from #{filename}...\n\n".center(50, "-")
      File.open(filename, "r") do |file|
        file.readlines.each do |line|
          name, cohort, hobby, country = line.chomp.split(',')
          @students << {name: name, cohort: cohort, hobby: hobby, country: country} #unless @students.each {|hash| hash.has_value?(cohort)}
        end
      end
      @load_status += 1
      puts "Loaded #{@students.count} students from #{filename}\n\n"
      break
    else
      puts 'File not found. Please input a valid file, or press return to skip'
      filename = gets.chomp
    end
  end
end

def initial_load
  filename = ARGV.first
  if filename.nil?
    load_students("students.csv")
    puts "Loaded #{@students.count} from #{filename}"
  elsif File.exist?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end


initial_load
#p @students
interactive_menu