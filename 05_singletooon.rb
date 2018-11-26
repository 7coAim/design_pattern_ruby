# require 'singleton'がrubyには標準である
class Singleton
  class << self

    def instance
      singleton
    end

    private

    def singleton
      @singleton ||= Singleton.new
    end
  end
end

# 実行
p Singleton.instance == Singleton.instance
