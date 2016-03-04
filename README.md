# data-structures-and-algorithms
### Why do this
This repo is to showcase and record some data structure and algorithm practice. I studied these concepts in college, but I wanted to go back over them. It was interesting programming these in Ruby as opposed to Java or C. Ruby is such a pretty language that it really makes writing and reading these algorithms easy to follow and understand.

### What I did
#### Implement a hash
Hashes are one of the most important data structures there is. With O(1) lookup, they are fast and useful. I implemented a hash which handles collision by chaining elements whose keys hash to the same location. To handle chaining I used a Node class and created Linked Lists off  each index in the containing array. Rehashing occurs when some tolerance limit is broke on an insertion. When that occurs the info in the existing hash is stored, the hash size is then doubled, and the hashing function is also changed. 

#### Red Black Trees
Red Black trees are my favorite type of binary tree. I learned AVL trees first, but I didn’t like all the branch length calculations. I think the Red Black tree is an awesome creative jump in logic which balances the tree storing only a True/False bit on each node. Coding a Red Black tree was really fun, and figuring out a DRY way of balancing the zig-zig and zig-zag patterns was interesting. I didn’t want 4 methods: zig-zig-right, zig-zig-left, zig-zag-right, and zig-zag-left. I wanted to handle both directions in one method. I did this by writing a helper method which determines the direction and returns a list or methods to perform. With the pattern correction abstracted out, I was able to write one method each for the zig-zig and zig-zag and it handled all the tree balancing. 

####  Sorting
##### Merge Sort
Writing this in Ruby was so satisfying. Merge sort is a complex concept, but the code is amazingly straight forward. 

##### Quick Sort
Quick sort was more engaging to write as a sorting algorithm. Quick sort sounds less complex than merge sort, but the code is more intense. It was really fun to write this out and for fun I swapped the values in the array without creating a temporary variable. However because I used math to swap the values, this sorting algorithm only works on numbers. If I wanted to handle other types of data I would either need to extend their data structures, write a swap method which knows how to swap non int values, or just create a temporary holding variable. 
