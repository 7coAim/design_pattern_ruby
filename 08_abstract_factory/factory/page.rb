module Factory
  class Page
    def initialize(title, author)
      @content = []
      @title   = title
      @author  = author
    end

    def add(item)
      @content << item
    end

    def output
      filename = @title + ".html"
      p make_html
      #writer = FileWriter.new(filename)
      #writer.write(make_html)
      #write.close
      p "#{filename} を作成しました"
    rescue => e
      p e
    end

    def make_html
    end
  end
end
