class Product
  def use
    raise NotImplementedError
  end
end

class Factory
  def create(owner)
    p = create_product(owner)
    register_product(p)
    p
  end

  def create_product(owner)
    raise NotImplementedError
  end

  def register_product(p)
    raise NotImplementedError
  end
end

# -----


class IDCard < Product
  def initialize(owner)
    puts "#{owner}のカードを作ります"
    @owner = owner
  end

  def use
    puts "#{@owner}のカードを使います"
  end

  def owner
    @owner
  end
end

class IDCardFactory < Factory
  def initialize
    @owners = []
  end

  def create_product(owner)
    IDCard.new(owner)
  end

  def register_product(product)
    @owners << product.owner
  end

  def owners
    @owners
  end
end

factory = IDCardFactory.new
card1 = factory.create('結城浩')
# => 結城浩のカードを作ります
card2 = factory.create('とむら')
# => とむらのカードを作ります
card3 = factory.create('佐藤花子')
# => 佐藤花子のカードを作ります
card1.use
# => 結城浩のカードを使います
card2.use
# => とむらのカードを使います
card3.use
# => 佐藤花子のカードを使います
p factory.owners
# => ["結城浩", "とむら", "佐藤花子"]
