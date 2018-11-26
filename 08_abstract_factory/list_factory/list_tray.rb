require './factory/tray'

module ListFactory
  class ListTray < Factory::Tray
    def initialize(caption)
      super(caption)
    end

    def make_html
      buffer = ''
      buffer << "<li>"
      buffer << "#{@caption}"
      buffer << "<ul>"

      @tray.each do |item|
        buffer << item.make_html
      end

      buffer << "</ul>"
      buffer << "</li>"
    end
  end
end
