class AbstractDisplay
  def open
  end

  def print
  end

  def close
  end

  def display
    open
    5.times do
      print
    end
    close
  end
end

# ---------------------------------------------

class CharDisplay < AbstractDisplay
  def initialize(ch)
    @ch = ch
  end

  def open
    printf '<<'
  end

  def print
    printf @ch
  end

  def close
    puts '>>'
  end
end

# ---------------------------------------------

class StringDisplay < AbstractDisplay
  def initialize(string)
    @string = string
    @width = string.length
    # @width = string.bytesize
  end

  def open
    print_line
  end

  def print
    puts "|#{@string}|"
  end

  def close
    print_line
  end

  private

  def print_line
    printf '+'
    @width.times do
      printf '-'
    end
    puts '+'
  end
end

# ---------------------------------------------

d1 = CharDisplay.new('H')
d2 = StringDisplay.new("Hello, World.")
d3 = StringDisplay.new('こんにちは。')

d1.display
d2.display
d3.display
