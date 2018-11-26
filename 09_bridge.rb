class Display
  def initialize(impl)
    @impl = impl
  end

  def open
    @impl.raw_open
  end

  def print
    @impl.raw_print
  end

  def close
    @impl.raw_close
  end

  def display
    open
    print
    close
  end
end

class CountDisplay < Display
  def multi_display(times)
    open
    times.times do
      print
    end
    close
  end
end

class DisplayImpl
  def raw_open
  end

  def raw_print
  end

  def raw_close
  end
end

class StringDisplayImpl < DisplayImpl
  def initialize(string)
    @string = string
    @width = string.length
  end

  def raw_open
    print_line
  end

  def raw_print
    puts "| #{@string} |"
  end

  def raw_close
    print_line
  end

  def print_line
    print "+"
    @width.times do
      print "-"
    end
    puts "+"
  end
end

class Main
  def main
    d1 = Display.new(StringDisplayImpl.new("Hello, Japan"))
    d2 = CountDisplay.new(StringDisplayImpl.new("Hello, World"))
    d3 = CountDisplay.new(StringDisplayImpl.new("Hello, Universe"))
    d1.display
    d2.display
    d3.display
    d3.multi_display(5)
  end
end

Main.new.main
