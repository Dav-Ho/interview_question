
def sort(unsorted_list)
  unsorted_list.sort { |a, b| b <=> a }
end

def find_duplicates(sorted_list)
  results = []
  sorted_list.each_with_index do |_value, index|
    if sorted_list[index] == sorted_list[index + 1]
      results.push(sorted_list[index])
    end
  end
    return results
end

def remove_duplicates(arr)
  arr.uniq!
end

def fill_array(value, length)
  arr = []
  i = 0
  until i > length
    arr.push(value)
    i += 1
  end
end

# if the length of the List is less than the bucket list, this callback function
# will be called.

def traditional_grading(unsorted_list)
sortedList = sort(unsorted_list)
i = 0
changeGrades = []
sortedList.length.times do
  if sortedList[i] >= 90
    changeGrades.push({
    score: sortedList[i],
    grade: "A"
      });
    elsif sortedList[i] >= 80 && sortedList[i] < 90
      changeGrades.push({
      score: sortedList[i],
      grade: "B"
      })
      elsif sortedList[i] >= 70  && sortedList[i] < 80
        changeGrades.push({
          score: sortedList[i],
          grade: "C"
        });
      elsif sortedList[i] >= 60  && sortedList[i] < 70
        changeGrades.push({
        score: sortedList[i],
        grade: "D"
      });
      else
        changeGrades.push({
        score: sortedList[i],
        grade: "F"
      });
    end
    i += 1;
end
  puts changeGrades
end

# This function will determine which grading will be appropriate. Traditional if
# the length is less than 5. Relative if more than five and has duplicates.

def relative_grading(unsorted_list)
   config = {
    buckets: ['A','B','C','D','F'],
    rounding: 'ceiling',
    debugging: false
  }

  if unsorted_list.length < config[:buckets].length
    console.log("Scorelist containes less than 5 value resulting in relative grading to be useless. Proceeding to traditional grading")
    return traditional_grading(unsorted_list)
  end
  # Preparing our list
  sortedList = sort(unsorted_list)
  grade_array = []
  duplicate_scores = sort(find_duplicates(sortedList)) #check for duplicates

  # # remove duplicates from array
  if duplicate_scores.length > 0
    sortedList = remove_duplicates(sortedList);
    puts "Duplicates Removed: #{sortedList}"
  end

  # Determine whether length of sortedList is less than grade buckets after removing duplicates.
  # If true, revert to normal grading.
  if sortedList.length < config[:buckets].length
    puts "Score list contains less than 5 values making relative_grading useless. Reverting to normal grading method."
    return traditional_grading(unsorted_list)
  end

  div_num = sortedList.length / config[:buckets].length.round
  modulus = sortedList.length % config[:buckets].length # Determine the remainder for the previous division
end

# Determine how the score list will be divided.


 relative_grading([99, 92, 91, 91, 89, 85, 83, 82, 80, 79, 78, 78, 77, 76, 75, 74, 62, 55, 43, 20])
