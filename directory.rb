@students = [] # Empty array available for all methods 

def interactive_menu

  loop do
    # 1. print the menu and ask the user what to do
    print_menu 
    # 2. read the input and save it into a variable
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
    when "1"
       input_students
    when "2"
    show_students
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
    end
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit" # 9 because we'll be adding more items
end 

def show_students
  print_header
  print 
  print_footer(@students)
end 

def input_students

  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # # create an empty array
  # students = []
  # get the first name
  name = gets.delete!("\n")
  
  # while the name is not empty, repeat this code      
while !name.empty?    
  # Prompting the user to enter a cohort 
    puts "For which cohort ?"
    cohort = gets.delete!("\n") 
# Checking if cohort is a valid month 
    while (cohort.downcase.match(/(january|february|march|april|may|june|july|august|september|october|november|december)/)) == nil do
    # exiting loop if cohort is empty 
      puts "The default cohort will be November " if cohort.empty?
      break                                       if cohort.empty?
    
    # If the user provides a cohort which is not a valid month, then we prompt the user to enter a cohort again
      puts "Your response was #{cohort}"
      puts "It seems that there is a typo "
      puts "Please write the month without abbreviation"
      puts "--------------------"
      puts "Please type cohort again"    
      cohort = gets.delete!("\n")  
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
    
    name = gets.delete!("\n")
  
  end
  
  if !@students.empty? 
  # Asking if they want to filter the names by the first letter 
  puts "Do you want to see the students with a name that starts with a specific letter?"
  puts "Please respond Yes or No."
  user_response = gets.delete!("\n")
  
  # checking the response provided by the user : must be yes or no. Anything else is not valid 
  while (user_response.downcase.match(/^[yes|no]+$/)) == nil do
    puts "Your response was #{user_response}"
    puts "Please answer Yes or No. No other response is accepted"    
    user_response = gets.delete!("\n")  
  end
  
    # if user says "no" then we display students array: only students with less than 12 characters 
return @students.reject{ |x| x[:name].length > 12} if user_response.downcase == "no"
    
  # if user says "yes" then we need to ask for the letter 
 puts "Which letter?" if user_response.downcase == "yes" 

letter = gets.delete!("\n")

# check whether the letter is a valid alphabet letter...nothing else 
# Also we need to check if the input is only ONE letter 
while (letter.length != 1 || letter[/[a-z]|[A-Z]/] == nil) do 
  puts "Only ONE letter of the ALPHABET is accepted "
  puts "No other character is allowed "
  letter = gets.delete!("\n") 
end

# dipslay only students with the correct first letter + reject students with name > 12 characters
 return @students.select{ |x| x[:name][0].downcase == letter.downcase }
 .reject{ |x| x[:name].length > 12}
 else 
   return []
 end 

# return @students.reject{ |x| x[:name].length > 12} 
 

end 



def print_header
  puts "The students of Villains Academy"
  puts "--------------" 
end 


def print

  
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
  
end 



def print_footer(names)
  puts "Overall, we have #{names.count} great students" if names.count > 1
  puts "Overall, we have #{names.count} great student"  if names.count == 1
  puts "NO STUDENT has been added to the list"  if names.count == 0
end 

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


