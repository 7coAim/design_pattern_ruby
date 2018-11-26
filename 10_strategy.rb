class Hand
  attr_reader :hand_value

  def initialize(hand_value)
    @hand_value = hand_value
  end

  def self.get_hand(hand_value)
    HAND[hand_value]
  end

  def is_stronger_then(h)
    fight(h) == 1
  end

  def is_weaker_then(h)
    fight(h) == -1
  end

  def to_s
    NAME[@hand_value]
  end

  private

  def fight(h)
    if HAND[@hand_value] == h
      0
    elsif (@hand_value + 1) % 3 == h.hand_value
      1
    else
      -1
    end
  end

  HAND_VALUE_GUU = 0
  HAND_VALUE_CHO = 1
  HAND_VALUE_PAA = 2

  HAND = [Hand.new(Hand::HAND_VALUE_GUU),
          Hand.new(Hand::HAND_VALUE_CHO),
          Hand.new(Hand::HAND_VALUE_PAA)]

  NAME = ["グー", "チョキ", "パー"].freeze
end


module Strategy
  def next_hand
    raise NotImplementedError.new("You must implement #{self.class}##{__method__}")
  end

  def study(win)
    raise NotImplementedError.new("You must implement #{self.class}##{__method__}")
  end
end


class WinningStrategy
  include Strategy

  def initialize(seed)
    @random = Random.new(seed)
    @won = false
  end

  def next_hand
    unless @won
      @prev_hand = Hand.get_hand(@random.rand(0...3))
    end
    @prev_hand
  end

  def study(win)
    @won = win
  end
end


class ProbStrategy
  include Strategy

  def initialize(seed)
    @random = Random.new(seed)
    @prev_hand_value = 0
    @current_hand_value = 0
    @history = Array.new(3, Array.new(3, 1))
  end

  def next_hand
    bet = @random.rand(0...get_sum(@current_hand_value))

    if bet < @history[@current_hand_value][0]
      hand_value = 0
    elsif bet < @history[@current_hand_value][0] + @history[@current_hand_value][1]
      hand_value = 1
    else
      hand_value = 2
    end

    @prev_hand_value = @current_hand_value
    @current_hand_value = hand_value
    Hand.get_hand(hand_value)
  end

  def study(win)
    if win
      @history[@prev_hand_value][@current_hand_value] += 1
    else
      @history[@prev_hand_value][(@current_hand_value + 1) % 3] += 1
      @history[@prev_hand_value][(@current_hand_value + 2) % 3] += 1
    end
  end

  private

  def get_sum(hv)
    @history[hv].inject(:+)
  end
end


class Player
  def initialize(name, strategy)
    @name = name
    @strategy = strategy
    @winconunt = 0
    @loseconunt = 0
    @gameconunt = 0
  end

  def next_hand
    @strategy.next_hand
  end

  def win
    @strategy.study(true)
    @winconunt += 1
    @gameconunt += 1
  end

  def lose
    @strategy.study(false)
    @loseconunt += 1
    @gameconunt += 1
  end

  def even
    @gameconunt += 1
  end

  def to_s
    "[#{@name}: #{@gameconunt} games, #{@winconunt} win, #{@loseconunt} lose]"
  end
end


class Main
  def main(args)
    unless args.length == 2
      usage
      exit
    end

    seed1 = args[0].to_i
    seed2 = args[1].to_i

    unless seed1 != 0 && seed2 != 0
      usage
      exit
    end

    player1 = Player.new("Taro", WinningStrategy.new(seed1))
    player2 = Player.new("Hana", ProbStrategy.new(seed2))

    10000.times do
      next_hand1 = player1.next_hand
      next_hand2 = player2.next_hand

      if next_hand1.is_stronger_then(next_hand2)
        puts "Winner: #{player1}"
        player1.win
        player2.lose
      elsif next_hand2.is_stronger_then(next_hand1)
        puts "Winner: #{player2}"
        player1.lose
        player2.win
      else
        puts "Even..."
        player1.even
        player2.even
      end
    end

    puts "Total result:"
    puts "#{player1}"
    puts "#{player2}"
  end

  def usage
    puts "Usage: ruby 10_strategy.rb randomseed1 randomseed2"
    puts "Example: ruby 10_strategy.rb 314 15"
  end
end

Main.new.main(ARGV)
