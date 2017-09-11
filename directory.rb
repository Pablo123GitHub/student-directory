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
    students << {name: name, cohort: :november, hobbies: :coding, country: :UK, height: 1.75} 
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # Asking if they want to filter the names by the first letter 
  puts "Do you want to see the students with a name that starts with a specific letter?"
  puts "Please respond Yes or No."
  user_response = gets.chomp
  
  while (user_response.downcase.match(/^[yes|no]+$/)) == nil do
    puts "Your response was #{user_response}"
    puts "Please answer Yes or No. No other response is accepted"    
    user_response = gets.chomp  
  end
  
    # if user says "no" then we display students array 
    # if user says "yes" then we need to ask for the letter 
    
return students.reject{ |x| x[:name].length > 12} if user_response.downcase == "no"
    
 puts "Which letter?" if user_response.downcase == "yes" 

letter = gets.chomp

while (letter.length != 1 || letter[/[a-z]|[A-Z]/] == nil) do 
  puts "Only ONE letter of the ALPHABET is accepted "
  puts "No other character is allowed "
  letter = gets.chomp 
end

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
  countStudent = students.length   
  index = 0
  while countStudent >0          
       newIndex = "#{index}".to_i
    puts "#{index+1}. #{students[newIndex][:name]}".center(50)
    puts "(#{students[newIndex][:cohort]} cohort)".center(60)  
    puts "Hobbies : #{students[newIndex][:hobbies]}, height: #{students[newIndex][:height]}, from #{students[newIndex][:country]} ".center(60)    
    puts " -----------------------------------------------------------"
      countStudent = countStudent - 1 
      index = index + 1       
  end 
end 



def print_footer(names)
  puts "Overall, we have #{names.count} great students"
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



