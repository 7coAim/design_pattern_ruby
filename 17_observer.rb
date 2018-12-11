module Observer
  def update(generator)
    raise NotImplementedError.new("You must implement #{self.class}##{__method__}")
  end
end

class NumberGenerator
  def initialize
    @observers = []
  end

  def add_observer(observer)
    @observers << observer
  end

  def delete_observer(observer)
    @observers.delete(observer)
  end

  def notify_observer()
    @observers.each do |observer|
      observer.update(self)
    end
  end

  # def get_number()
  #   raise NotImplementedError.new("You must implement #{self.class}##{__method__}")
  # end

  def execute()
    raise NotImplementedError.new("You must implement #{self.class}##{__method__}")
  end
end

class RandomNumberGenerator < NumberGenerator
  attr_reader :number

  def initialize
    super
    @random = Random.new
  end

  def execute
    20.times do
      @number = @random.rand(0...50)
      notify_observer
    end
  end
end

class DigitObserver
  include Observer

  def update(generator)
    puts "DigitObserver:#{generator.number}"
    sleep(0.1)
  end
end

class GraphObserver
  include Observer

  def update(generator)
    printf "GraphObserver:"
    generator.number.times do
      printf "*"
    end
    puts ""
    sleep(0.1)
  end
end

class Main
  def self.main
    generator = RandomNumberGenerator.new
    observer_1 = DigitObserver.new
    observer_2 = GraphObserver.new
    generator.add_observer(observer_1)
    generator.add_observer(observer_2)
    generator.execute
  end
end

Main.main
