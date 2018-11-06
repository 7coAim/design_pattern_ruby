# 継承するパターン
class PrintBanner < Banner
  def initialize(string)
    super(string)
  end
  
  def print_weak
    show_with_paren
  end
  
  def print_strong
    show_with_aster
  end
end

# 委譲するパターン
class PrintBanner
  def initialize(string)
    @banner = Banner.new(string)
  end

  def print_weak
    @banner.show_with_paren
  end

  def print_strong
    @banner.show_with_aster
  end
end

# 実行
p = PrintBanner.new('Hello')
p.print_weak
p.print_strong