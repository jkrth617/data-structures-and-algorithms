def my_quick_sort(my_arr) 
  qs_helper(my_arr, my_arr.sample)#pivot is randomly selected
end

def qs_helper(arr, pivot)
  return arr if arr.length <=1
  left = 0
  right = arr.length-1 
  while left < right
    p arr
    if arr[left] >= pivot and arr[right] <= pivot
      #swap without creating temp variable only works for ints
      arr[left] = arr[left] - arr[right]
      arr[right] = arr[right] + arr[left]
      arr[left] = arr[right] - arr[left]
    end    
    left +=1 if arr[left] < pivot
    right -=1 if arr[right] > pivot
    if arr[left] == arr[right]
      arr[left] >= pivot ? right -= 1 : left += 1
    end
  end
  left_chunk = arr[0...left]
  right_chunk = arr[left+1..-1]
  (rec_helper(left_chunk, left_chunk.sample) << arr[left]) + rec_helper(right_chunk, right_chunk.sample)
end