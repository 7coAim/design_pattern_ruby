require './factory/page'

module ListFactory
  class ListPage < Factory::Page
    def initialize(title, author)
      super(title, author)
    end

    def make_html
      buffer = ''
      buffer << "<html><head><title>#{@title}</title></head>"
      buffer << "<body>"
      buffer << "<h1>#{@title}</h1>"
      buffer << "<ul>"

      @content.each do |item|
        buffer << item.make_html
      end

      buffer << "</ul>"
      buffer << "<hr><address>#{@author}</address>"
      buffer << "</body></html>"
    end
  end
end
