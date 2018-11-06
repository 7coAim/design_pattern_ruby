class Aggregate
  def iterator
  end
end

class Iterator
  def has_next
  end

  def next
  end
end

class Book
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def get_name
    @name
  end
end

class BookShelf < Aggregate
  attr_accessor :books, :last

  def initialize(max_size)
    @books = []
    @max_size = max_size
    @last = 0
  end

  def get_book_at(index)
    @books[index]
  end

  def append_book(book)
    @books[last] = book
    @last += 1
  end

  def get_length
    @last
  end

  def iterator
    BookShelfIterator.new(self)
  end
end

class BookShelfIterator < Iterator
  attr_accessor :book_shelf, :index

  def initialize(book_shelf)
    @book_shelf = book_shelf
    @index = 0
  end

  def has_next
    if @index < @book_shelf.get_length
      true
    else
      false
    end
  end

  def next
    book = @book_shelf.get_book_at(index)
    @index += 1

    book
  end
end

class Main
  def iterate
    book_shelf = BookShelf.new(4)

    book_shelf.append_book(Book.new("Around the World in 80 Days"))
    book_shelf.append_book(Book.new("Bible"))
    book_shelf.append_book(Book.new("Cinderella"))
    book_shelf.append_book(Book.new("Daddy-Long_Legs"))

    it = book_shelf.iterator

    while it.has_next
      book = it.next
      p book.get_name
    end
  end
end

i = Main.new
i.iterate