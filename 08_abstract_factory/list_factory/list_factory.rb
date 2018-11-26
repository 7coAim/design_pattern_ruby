require './list_factory/list_link'
require './list_factory/list_tray'
require './list_factory/list_page'

module ListFactory
  class ListFactory
    def create_link(caption, url)
      ::ListFactory::ListLink.new(caption, url)
    end

    def create_tray(caption)
      ::ListFactory::ListTray.new(caption)
    end

    def create_page(title, author)
      ::ListFactory::ListPage.new(title, author)
    end
  end
end
