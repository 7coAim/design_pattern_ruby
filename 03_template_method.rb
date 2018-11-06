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
    # 表示幅を求めて格納する
    # @width = print_size(string)
    # 文字数を格納する
    # @width = string.length
    # バイス数を格納するが 文字コードがUTF-8なら、漢字やひらがなは3バイトで計算される
    @width = string.bytesize
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

  # 文字列の表示幅を求める
  def print_size(string)
    string.each_char.map{|c| c.bytesize == 1 ? 1 : 2}.inject(:+)
  end
end

# ---------------------------------------------

d1 = CharDisplay.new('H')
d2 = StringDisplay.new("Hello, World.")
d3 = StringDisplay.new('こんにちは。')

d1.display
d2.display
d3.display

puts d1.class
puts d2.class
puts d3.class
