import scala.io.Source
import java.io.File
import scala.io.StdIn.readLine
import java.io.PrintWriter

// Defintion of Book class with necessary attributes
class Book (val isbn: Long, val author: String, val title: String, val publisher: String)

// Definiton of sorting function that takes an array of Books and a function as parameters
def sortBooks(books: Array[Book], block: (Book, Book) => Boolean): Unit = {

  // Nested for loop for bubble sort using the provided function
  for (i <- 0 to books.size - 1) {
    for (j <- i + 1 to books.size - 1) {
      if (block(books(i), books(j)) == false) {
        val temp = books(i)
        books(i) = books(j)
        books(j) = temp
      }
    }
  }

  // Write sorted list of books to the file
  val writer = new PrintWriter("textfile.txt")
  for (i <- 0 to books.size - 1) {
    writer.write(books(i).isbn + ", " + books(i).author + ", " + books(i).title + ", " + books(i).publisher + "\n")
  }
  writer.close()
}

// Declare arrays and file reader necessary to get the list of books from the file
var bookList = Array[Book]()
var words = Array[String]()
val file = Source.fromFile("textfile.txt")
val lines = file.getLines()

// For loop to read all the lines in the file
for (line <- lines) {
  words = line.split(" ")

  // Format words correctly before adding to the book list
  for (i <- 0 to words.size - 1) {
    if (words(i).contains(",")) {
      words(i) = words(i).dropRight(1)
    }
  }
  var author = words(1) + " " + words(2)

  // Add books to the list
  var book = new Book(words(0).toLong, author, words(3), words(4))
  bookList = bookList :+ book
}

// Prompt user to select sorting criteria
println("Select what to sort the books by (isbn or title):")
val sort = readLine()

// Check input given by user
if (sort == "isbn") {

  // Prompt user to select sorting direction
  println("Select what direction to sort in (ascending or descending):")
  val direction = readLine()

  // Check input and call sorting function accordingly
  if (direction == "ascending") {
    sortBooks(bookList, {(a: Book, b: Book) => a.isbn < b.isbn})
  }
  else if (direction == "descending") {
    sortBooks(bookList, {(a: Book, b: Book) => a.isbn > b.isbn})
  }
  else {
    println("Invalid direction, please try again")
  }
}
else if (sort == "title") {
  sortBooks(bookList, {(a: Book, b: Book) => a.title < b.title})
}
else {
  println("Invalid sorting criteria, please try again")
}