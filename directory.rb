def input_students

  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
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
    students << {name: name, cohort: cohort, hobbies: :coding, country: :UK, height: 1.75} 
    puts "Now we have #{students.count} students" if students.count > 1
    puts "Now we have #{students.count} student" if students.count == 1
    # get another name from the user  
    puts "Please enter another student name "     
    puts "To finish, just hit return twice"       
    
    name = gets.delete!("\n")
  
  end

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
return students.reject{ |x| x[:name].length > 12} if user_response.downcase == "no"
    
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
 students.select{ |x| x[:name][0].downcase == letter.downcase }
 .reject{ |x| x[:name].length > 12}

end 



def print_header
  puts "The students of Villains Academy"
  puts "--------------" 
end 


def print(students)
  # students.each_with_index do |student, index|    
  #   puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)" 
  # end
  
  # countStudent = students.length   
  # index = 0
  # while countStudent >0          
  #      newIndex = "#{index}".to_i
  #   puts "#{index+1}. #{students[newIndex][:name]}".center(50)
  #   puts "(#{students[newIndex][:cohort]} cohort)".center(60)  
  #   puts "Hobbies : #{students[newIndex][:hobbies]}, Height: #{students[newIndex][:height]}, from #{students[newIndex][:country]} ".center(60)    
  #   puts " -----------------------------------------------------------"
  #     countStudent = countStudent - 1 
  #     index = index + 1       
  # end 
  
  newArr = students.group_by {|x| x[:cohort]}
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
end 

students = input_students

print_header
print(students)
print_footer(students)


# students = [ 
# ["Dr. Hannibal Lecter", :november],
# ["Darth Vader", :november],
# ["Nurse Ratched", :november],
# ["Michael Corleone", :november],
# ["Alex DeLarge", :november],
# ["The Wicked Witch of the West", :november],
#  ["Terminator", :november],
#  ["Freddy Krueger", :november],
#  ["The Joker", :november],
#  ["Joffrey Baratheon", :november],
# [ "Norman Bates", :november ]
# ]

# students = [
#   {name: "Dr. Hannibal Lecter", cohort: :november },
#   {name: "Darth Vader", cohort: :november },
#   {name: "Nurse Ratched", cohort: :november },
#   {name: "Michael Corleone", cohort: :november },
#   {name: "Alex DeLarge", cohort: :november },
#   {name: "The Wicked Witch of the West", cohort: :november },
#   {name: "Terminator", cohort: :november },
#   {name: "Freddy Krueger", cohort: :november },
#   {name: "The Joker", cohort: :november },
#   {name: "Joffrey Baratheon", cohort: :november },
#   {name: "Norman Bates", cohort: :november }
# ]



