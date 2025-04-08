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

# Declare array for a list of book items
bookList=[]

# Generate random numbers and strings for the book items and add them to the array
for i in 1..10000 do
  isbn = rand(100000000000..999999999999)
  first = (0..7).map {(97 + rand(26)).chr}.join
  last = (0..5).map {(97 + rand(26)).chr}.join
  title = (0..7).map {(97 + rand(26)).chr}.join
  publisher = (0..7).map {(97 + rand(26)).chr}.join
  book = Book.new(isbn, first, last, title, publisher)
  bookList.push(book)
end

puts "#{i} books created"

# Write all 10000 books to the textfile
File.open("textfile.txt", "w") do |file|
  for i in 0..9999 do
    file.write(bookList[i].isbn.to_s + ", " + bookList[i].author + ", " + bookList[i].title + ", " + bookList[i].publisher + "\n")
  end
end

puts "#{i + 1} books written to file"