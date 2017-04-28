def duplicates(array)
 sort_array = array.sort
 duplicate = []

 i = 0
 while i < array.length
  if sort_array[i] == sort_array[i + 1] # compare the initial index and next index
    duplicate << sort_array[i]
    puts duplicate
    break # end the program since we found the duplicate
  else
    i += 1 # if no duplicate, increment by 1
  end
  end

  # if there are no duplicates display -1
  if duplicate.length == 0
    puts "-1"
  end

end

puts "Problem  with duplicate"
duplicates([2,5,3,2,1])
puts "---------------------------"
puts "Problem with no duplicates"
duplicates([5,3,2,1])
