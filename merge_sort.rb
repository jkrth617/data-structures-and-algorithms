def merge_sort(arr)
  return arr if arr.length == 1
  left = merge_sort(arr[0...arr.length/2])
  right = merge_sort(arr[arr.length/2..-1])
  merge(left,right)
end

def merge(left, right)
  left_index = 0
  right_index = 0
  sorted_array = []
  until left_index == left.length or right_index == right.length
    if left[left_index] <= right[right_index]
      sorted_array << left[left_index]
      left_index += 1
    else
      sorted_array << right[right_index]
      right_index += 1
    end
  end
  left_index == left.length ? sorted_array + right : sorted_array + left
end