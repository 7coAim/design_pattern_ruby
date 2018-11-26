require './factory/item'

module Factory
  class Tray < Factory::Item
    def initialize(caption)
      @tray = []
      super(caption)
    end

    def add(item)
      @tray << item
    end
  end
end
