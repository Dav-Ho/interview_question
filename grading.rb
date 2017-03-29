# interview question for in Ruby code  

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
  length = array.length
  sum = 0
  while index < length
    sum += array[index]
    index += 1
  end
  sum
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

# Traditional_grading will be called if the length of the List is less than the bucket list, which is 5.

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
      score: sorted_list[i], grade: 'B'
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

# This is the main function that determines which grading will be appropriate.
# Traditional if the length is less than 5. Relative if more than five and has duplicates.

def score_with_grade(unsorted_list)
  config = {
      buckets: [
        'A', 'B', 'C', 'D', 'F'], # each bucket has a letter grade for score.
      rounding: 'ceiling',
      debugging: true
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

    while sorted_list[index] == duplicate_scores[0]
    grade_array.push({
      score: sorted_list[index], # score that is being parsed in the array
      grade: config[:buckets][bucket_pointer] # grade that is being given within the bucket
    })
    duplicate_scores.shift # delete the score from the array its been pushed to.
    end

    grade_array.push({
      score: sorted_list[index], # The score we are parsing in the sorted_list
      grade: config[:buckets][bucket_pointer] # The letter value associated with the bucket we are within
    })
      bucket_counter += 1;
      index += 1
    end

    puts grade_array
end
# test for more than 5 characters
score_with_grade([99, 92, 91, 91, 89, 85, 83, 82, 80, 79, 78, 78, 77, 76, 75, 74, 62, 55, 43, 20])

# test for less than 5 characters
score_with_grade([90, 80, 50, 40])
