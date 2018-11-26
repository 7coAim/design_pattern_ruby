module Framework
  module Product
    def use(string)
      raise NotImplementedError
    end

    def create_clone
      raise NotImplementedError
    end
  end

  class Manager
    attr_reader :showcase

    def initialize
      @showcase = {}
    end

    def register(name, proto)
      @showcase[name] = proto
    end

    def create(protoname)
      p = @showcase[protoname]
      p.create_clone
    end
  end
end


class MessageBox
  include Framework::Product

  attr_reader :decochar

  def initialize(decochar)
    @decochar = decochar
  end

  def use(string)
    length = string.length
    print_line(length)
    puts @decochar + " " + string + " " + @decochar
    print_line(length)
  end

  # ここまで丁寧にやらなくても良さそうです。
  def create_clone
    p = nil
    begin
      p = self.clone
    rescue ArgumentError
    end
    p
  end

  def print_line(length)
    (length + 4).times do
      print(@decochar)
    end
    puts ""
  end
end

class UnderlinePen
  include Framework::Product

  def initialize(ulchar)
    @ulchar = ulchar
  end

  def use(string)
    puts '"' + string + '"'
    print (" ")
    string.length.times do
      print(@ulchar)
    end
    puts ""
  end

  def create_clone
    p = nil
    begin
      p = self.clone
    rescue ArgumentError
    end
    p
  end
end

manager = Framework::Manager.new
mbox = MessageBox.new("*")
sbox = MessageBox.new("/")
upen = UnderlinePen.new("~")

manager.register("warning box", mbox)
manager.register("slash box", sbox)
manager.register("strong message", upen)

# mbox.cloneでも可能
p1 = manager.create("warning box")
p1.use("Hello")

p2 = manager.create("slash box")
p2.use("Hello")

p3 = manager.create("strong message")
p3.use("Hello")
