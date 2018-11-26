class Builder
  def make_title(title)
  end

  def make_string(str)
  end

  def make_items(items)
  end

  def close
  end
end

class Director
  def initialize(builder)
    @builder = builder
  end

  def construct
    @builder.make_title('Greeting')
    @builder.make_string('朝から昼にかけて')
    @builder.make_items(['おはようございます。', 'こんにちは。'])
    @builder.make_string('夜に')
    @builder.make_items(['こんばんは。', 'おやすみなさい。', 'さようなら。'])
    @builder.close()
  end
end

class TextBuilder < Builder
  def initialize
    @buffer = []
  end

  def make_title(title)
    @buffer << "==================="
    @buffer << "『" + title + "』"
  end

  def make_string(str)
    @buffer << "▪️" + str
  end

  def make_items(items)
    items.each do |item|
      @buffer << "." + item
    end
  end

  def close
    @buffer << "==================="
  end

  def get_result
    @buffer.join("\n")
  end
end

### htmlはいずれ対応
# class HtmlBuilder < Builder
# end

class Main
  def main(args)
    if args.length != 1
      usage
      exit
    end
    if args[0] == 'plain'
      text_builder = TextBuilder.new
      director = Director.new(text_builder)
      director.construct
      result = text_builder.get_result
      puts result
    elsif args[0] == 'html'
      html_builder = HtmlBuilder.new
      director = Director.new(html_builder)
      director.construct
      filename = html_builder.get_result
      puts filename + "が作成されました"
    else
      usage
      exit
    end
  end

  def usage
    puts "ちがうにゃ"
  end
end

Main.new.main(ARGV)
