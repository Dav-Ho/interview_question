# Athenium Coding Exercise
# -------------------------
# A teacher gives a class of students an exam. She decides to grade the
# exam using the following method:
# * A score in the top 20% of all scores is an A.
# * A score in the next 20% of scores is a B.
# * A score in the next 20% of scores is a C.
# * A score in the next 20% of scores is a D.
# * A score in the bottom 20% of scores is an F.
# For example, if a class of 20 students has the following scores:
# 99, 92, 91, 91, 89, 85, 83, 82, 80, 79, 78, 78, 77, 76, 75, 74, 62, 55,
# 43, 20
# As there are 20 grades in this example, each 20% grade bucket will
# contain 4 scores. The first four scores (99, 92, 91, 91) would be an A,
# scores 5 through 8 (89,85, 83, 82) would be a B, scores 9 through 12 (80,
# 79, 78, 78) would be a C,scores 13 through 16 would be a D (77, 76, 75,
# 74) and scores 17 through 20 (62, 55, 43, 20) would be an F.
# Write a function that takes an arbitrary (possibly unsorted) score list
# of any length (not necessarily the list used as an example above) as a
# parameter, and returns a grade for each score.
# ADDITIONAL REQUIREMENT: If there are two (or more) scores that are
# identical, then those identical numerical scores must always receive the
# same grade, even if that causes the grade distribution to be uneven.
# We will use the following criteria to evaluate your solution:
# 1) Does the function return a data structure that contains the same
# number of scores as the input along with a corresponding letter grade of
# A, B, C, D, F. Example output for input [99,82,80,75,60]: [[99, A], [82,
# B], [80, C], [75, D], [60, F]]
# You are not required to use this exact output format, as long as it's
# clear what grade goes with each score in the input.
# 2) Do identical scores receive the same letter grade (to accomplish this
# the number of scores receiving each grade may be uneven, which is fine)
# 3) Does it gracefully and consistently handle lists that are not
# divisible by 5
# 4) Does it handle lists that contain fewer than 5 scores.
# 5) Is your code syntactically valid for the language you chose (we will
# be executing your code)
# 6) Is your code well commented
# 7) Is your code well structured and extensible
# Please complete this exercise by choosing your desired language from one
# of the options below and filling in the function for that language.
# Please only complete ONE.

# Ruby
# def atheniumGrading(scores)
# // your code here
# return scoreWithGrades
# end
# puts(atheniumGrading([99, 92, 91, 91, 89, 85, 83, 82, 80, 79, 78, 78, 77,
# 76, 75, 74, 62, 55, 43, 20]))




def sort(unsorted_list)
  unsorted_list.sort { |a, b| b <=> a }
end

# move duplicates into a new array
def find_duplicates(sorted_list)
  results = []
  sorted_list.each_with_index do |_value, index|
    if sorted_list[index] == sorted_list[index + 1]
      results.push(sorted_list[index])
    end
  end
    results
end

# remove duplicates from sorted_list after moving them.
def remove_duplicates(arr)
  arr.uniq!
end

# Gives the total sum of all the elements in the array
def sum_array(array)
  index = 0
  length = array.length # store array length
  sum = 0   # total sum in array
  while index < length
    sum += array[index] # add each index into sum
    index += 1
  end
  sum  # display sum
end

# Fill array with elements a number of times.
def fill_array(value, length)
  arr = []
  i = 0
  until i >= length
    arr.push(value)
    i += 1
  end
  return arr
end

# Traditional_grading will be call-back function in case the length of the List is less than 5.

def traditional_grading(unsorted_list)
sorted_list = sort(unsorted_list)
i = 0
change_grades = []

# Match score with the correct grade.
sorted_list.length.times do
  if sorted_list[i] >= 90
    change_grades.push(
    {
      score: sorted_list[i],
      grade: 'A'
    })
  elsif sorted_list[i] >= 80
    change_grades.push(
    {
      score: sorted_list[i],
      grade: 'B'
    })
  elsif sorted_list[i] >= 70
    change_grades.push({
    score: sorted_list[i],
    grade: 'C'
    })
  elsif sorted_list[i] >= 60
    change_grades.push({
    score: sorted_list[i],
    grade: 'D'
    });
  else
    change_grades.push({
    score: sorted_list[i],
    grade: 'F'
    })
  end
    i += 1
end
  puts change_grades
end

# score_with_grade is the main function that determines which grading will be appropriate.
# Traditional if the length is less than 5. Relative if more than five and has duplicates.

def score_with_grade(unsorted_list)
  config = {
      buckets: [
        'A', 'B', 'C', 'D', 'F'], # each bucket has a letter grade for score.
      debugging: false
  }

  if unsorted_list.length < config[:buckets].length
    puts "Scorelist contains less than 5 value resulting in relative grading to be useless. Proceeding to traditional grading"
    return traditional_grading(unsorted_list)
  end
  # Preparing our list
  sorted_list = sort(unsorted_list)
  grade_array = []
  duplicate_scores = sort(find_duplicates(sorted_list)) # check for duplicates

  # remove duplicates from array
  if duplicate_scores.length > 0
    sorted_list = remove_duplicates(sorted_list)
    puts "Duplicates Removed: #{sorted_list}"
  end

  # Determine whether length of sorted_list is less than grade buckets after
  # removing duplicates. If true, revert to normal grading.

  if sorted_list.length < config[:buckets].length
    puts 'Score list contains less than 5 values making score_with_grade useless
    .Reverting to normal grading method.'
    return traditional_grading(unsorted_list)
  end

  # Determine how the score list will be divided.

  div_num = sorted_list.length / config[:buckets].length.round
  modulus = sorted_list.length % config[:buckets].length

  grade_buckets = fill_array(div_num, config[:buckets].length)

  # Check the bucket length is equal
  if grade_buckets.length != config[:buckets].length
    puts "Number of the buckets are not the same as the number buckets defined
    in the config. Exiting the program."
  end

  # for every extra numbers, the buckets need to be increased by one.
  if modulus != 0
    index = 0
    while index < modulus
      grade_buckets[index] += 1
      index += 1
    end
  end

  if unsorted_list.length != (sum_array(grade_buckets) + duplicate_scores.length)
    puts 'There was an error calculating the size of each grade bucket.'
    return false
  end

  bucket_pointer = 0 # current point on the bucket
  bucket_counter = 0 # counter to determine each score place in each bucket
  index = 0

  while index < sorted_list.length
    if config[:debugging] == true
      puts "Iteration ##{index + 1} on score of #{sorted_list[index]}"
      puts "Pointer: #{bucket_pointer}"
      puts "Counter: #{bucket_counter}"
    end

  # if the counter exceeds the bucket maximum value the pointer needs to be moved to the next bucket so we may assign this.

    if bucket_counter == grade_buckets[bucket_pointer]
      bucket_pointer += 1 # increment bucket_pointer
      bucket_counter = 0  # reset bucket_counter to 1
    end

  # Checks if current score exist in duplicate score array. If this is true the function returns the duplicate scores back to the score list with the grade matching its duplicate.
    while sorted_list[index] == duplicate_scores[0]
    grade_array.push({
      score: sorted_list[index], # score that is being parsed in the array
      grade: config[:buckets][bucket_pointer] # grade that is being given within the bucket
    })
    duplicate_scores.shift # delete the score from the array its been pushed to.
    end
  
  # parse score in the list into grade.
    grade_array.push({
      score: sorted_list[index], # The score we are parsing in the sorted_list
      grade: config[:buckets][bucket_pointer] # The letter value associated with the bucket we are within
    })
      bucket_counter += 1
      index += 1  # increment 1
    end

    puts grade_array # display scores with matching grrade.
end
# test for more than 5 characters
score_with_grade([99, 92, 91, 91, 89, 85, 83, 82, 80, 79, 78, 78, 77, 76, 75, 74, 62, 55, 43, 20])

# test for less than 5 characters
score_with_grade([90, 80, 50, 40])
