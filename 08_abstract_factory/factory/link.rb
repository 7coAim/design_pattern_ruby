require './factory/item'

module Factory
  class Link < Factory::Item
    def initialize(caption, url)
      super(caption)
      @url = url
    end
  end
end
