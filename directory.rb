@students = [] # Empty array available for all methods

def interactive_menu

  loop do
    # 1. print the menu and ask the user what to do
    print_menu
    # 2. read the input and save it into a variable
    # 3. do what the user has asked
    process(STDIN.gets.chomp)
  end
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
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" # 9 because we'll be adding more items
end

def show_students
  print_header
  print_students_list
  print_footer
end

def input_students

  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # # create an empty array
  # students = []
  # get the first name
  name = STDIN.gets.delete!("\n")

  # while the name is not empty, repeat this code
while !name.empty?
  # Prompting the user to enter a cohort
    puts "For which cohort ?"
    cohort = STDIN.gets.delete!("\n")
# Checking if cohort is a valid month
while (cohort.downcase.match(/(\bjanuary\b|\bfebruary\b|\bmarch\b|\bapril\b|\bmay\b|\bjune\b|\bjuly\b|\baugust\b|\bseptember\b|\boctober\b|\bnovember\b|\bdecember\b)/)) == nil do
    # exiting loop if cohort is empty
      puts "The default cohort will be November " if cohort.empty?
      break                                       if cohort.empty?

    # If the user provides a cohort which is not a valid month, then we prompt the user to enter a cohort again
      puts "Your response was #{cohort}"
      puts "It seems that there is a typo "
      puts "Please write the month without abbreviation"
      puts "--------------------"
      puts "Please type cohort again"
      cohort = STDIN.gets.delete!("\n")
    end

# We exit the above loop when cohort is empty or when cohort has a valid month
    cohort = cohort.capitalize.to_sym
    cohort = :November if cohort.empty?   # Turning cohort into a symbol

    # add the student hash to the array
    @students << {name: name, cohort: cohort, hobbies: :coding, country: :UK, height: 1.75}
    puts "Now we have #{@students.count} students" if @students.count > 1
    puts "Now we have #{@students.count} student" if @students.count == 1
    # get another name from the user
    puts "Please enter another student name "
    puts "To finish, just hit return twice"

    name = STDIN.gets.delete!("\n")
  end

 return @students.reject{ |x| x[:name].length > 12}


end



def print_header
  puts "The students of Villains Academy"
  puts "--------------"
end


def print_students_list


    if !@students.empty?
    # Asking if they want to filter the names by the first letter
    puts "Do you want to see the students with a name that starts with a specific letter?"
    puts "Please respond Yes or No."
    user_response = STDIN.gets.delete!("\n")

    # checking the response provided by the user : must be yes or no. Anything else is not valid
    while (user_response.downcase.match(/^[yes|no]+$/)) == nil do
      puts "Your response was #{user_response}"
      puts "Please answer Yes or No. No other response is accepted"
      user_response = STDIN.gets.delete!("\n")
    end


  # return @students.reject{ |x| x[:name].length > 12}

   if user_response.downcase == "no"
     newArr = @students.group_by {|x| x[:cohort]}
     newArr.each do |cohort, arr|
       countStudent = arr.length
       index = 0
       puts "**************************".center(50)
       puts "Cohort for #{cohort.upcase} ".center(50)
       puts "**************************".center(50)
       while countStudent >0
            newIndex = "#{index}".to_i
         puts "#{index+1}. #{arr[newIndex][:name]}".center(50)
         puts "(#{arr[newIndex][:cohort]} cohort)".center(60)
         puts "Hobbies : #{arr[newIndex][:hobbies]}, Height: #{arr[newIndex][:height]}, from #{arr[newIndex][:country]} ".center(60)
         puts " -----------------------------------------------------------"
           countStudent = countStudent - 1
           index = index + 1
       end
     end
   elsif  user_response.downcase == "yes"
     # if user says "yes" then we need to ask for the letter
    puts "Which letter?" if user_response.downcase == "yes"

   letter = STDIN.gets.delete!("\n")

   # check whether the letter is a valid alphabet letter...nothing else
   # Also we need to check if the input is only ONE letter
   while (letter.length != 1 || letter[/[a-z]|[A-Z]/] == nil) do
     puts "Only ONE letter of the ALPHABET is accepted "
     puts "No other character is allowed "
     letter = STDIN.gets.delete!("\n")
   end

     newArr = @students
     .select{ |x| x[:name][0].downcase == letter.downcase }
     .reject{ |x| x[:name].length > 12}
     .group_by {|x| x[:cohort]}
     newArr.each do |cohort, arr|
       countStudent = arr.length
       index = 0
       puts "**************************".center(50)
       puts "Cohort for #{cohort.upcase} ".center(50)
       puts "**************************".center(50)
       while countStudent >0
            newIndex = "#{index}".to_i
         puts "#{index+1}. #{arr[newIndex][:name]}".center(50)
         puts "(#{arr[newIndex][:cohort]} cohort)".center(60)
         puts "Hobbies : #{arr[newIndex][:hobbies]}, Height: #{arr[newIndex][:height]}, from #{arr[newIndex][:country]} ".center(60)
         puts " -----------------------------------------------------------"
           countStudent = countStudent - 1
           index = index + 1
         end
       end
         else
           return []
       end
     end

  # dipslay only students with the correct first letter + reject students with name > 12 characters
  #  return @students.select{ |x| x[:name][0].downcase == letter.downcase }
  #  .reject{ |x| x[:name].length > 12}

end

def print_footer
  puts "Overall, we have #{@students.count} great students" if @students.count > 1
  puts "Overall, we have #{@students.count} great student"  if @students.count == 1
  puts "NO STUDENT has been added to the list"  if @students.count == 0
end

def save_students
  file = File.open("students.csv", "w")

  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
filename = ARGV.first
return if filename.nil?
if File.exists?(filename)
  load_students(filename)
  puts "Loaded #{@students.count} from #{filename}"
else
  puts "Sorry, #{filename} doesn't exist"
  exit
end
end

try_load_students
interactive_menu

# students = input_students
#
#
# if students.count > 0
# print_header
# print(students)
# end
#
# print_footer(students)
