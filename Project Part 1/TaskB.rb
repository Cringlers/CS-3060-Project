# Class for book items with necessary attributes and an initializer
class Book 
  attr_accessor :isbn, :author, :title, :publisher

  def initialize(isbn, first, last, title, publisher)
    @isbn = isbn
    @author = first + " " + last
    @title = title
    @publisher = publisher
  end
end

# Function to sort the list of books and write them to the textfile
def sortBooks(bookList, &block)

  # Loop for bubble sort
  loop do
    unsorted = false

    # Iterate through list for each loop
    for i in 0..bookList.size - 2 do

      # Make code block call and do necessary comparisons and swaps
      compare = block.call(bookList[i], bookList[i + 1])
      if compare == false then
        bookList[i], bookList[i + 1] = bookList[i + 1], bookList[i]
        unsorted = true
      end
    end

    # Check if list still needs sorting
    if unsorted == false then
      break
    end
  end

  # Write sorted list back to the textfile
  File.open("textfile.txt", "w") do |file|
    for i in 0..bookList.size - 1 do
      file.write(bookList[i].isbn.to_s + ", " + bookList[i].author + ", " + bookList[i].title + ", " + bookList[i].publisher + "\n")
    end
  end
end

# Declare array for book items and words to read from the textfile
bookList=[]
words=[]

# Open file and read all 10000 books to put into the array
File.open("textfile.txt", "r") do |file|
  file.each_line do |line|
    words = line.split

    # Separate each line into proper book attributes
    for i in 0..words.length-1 do
      words[i] = words[i].chomp(',')
    end

    # Add books to array
    book = Book.new(words[0], words[1], words[2], words[3], words[4])
    bookList.push(book)
  end
end

# Prompt user to pick sorting criteria
puts "Select what to sort the books by (isbn or title):"
sort = gets.chomp

# Check input validity
if sort != "isbn" && sort != "title"
  puts "Invalid sorting criteria, please try again"
  return
end

if sort == "isbn" then

  # Prompt user to select sorting direction
  puts "Select what direction to sort in (ascending or descending):"
  direction = gets.chomp

  if direction == "ascending" then
    sortBooks(bookList) {|a, b| a.isbn < b.isbn}
    
  elsif direction == "descending" then
    sortBooks(bookList) {|a, b| a.isbn > b.isbn}
    
  else
    puts "Invalid direction, please try again"
  end

elsif sort == "title" then
  sortBooks(bookList) {|a, b| a.title < b.title}

else
  puts "Invalid sorting criteria, please try again"
end