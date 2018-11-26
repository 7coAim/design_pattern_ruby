require './factory/factory'
require './factory/factory'

class Main
  def main(args)
    if args.length != 1
      usage
      exit
    end

    factory = Factory::Factory.new.get_factory(args[0])

    asahi = factory.create_link("朝日新聞", "https://asashi.com")
    yomiuri = factory.create_link("読売新聞", "https://yomiuri.co.jp")

    us_yahoo = factory.create_link("Yahoo USA", "https://yahoo.com")
    jp_yahoo = factory.create_link("Yahoo Japan", "https://yahoo.co.jp")

    excite = factory.create_link("Excite", "https://excite.com")
    google = factory.create_link("Google", "https//google.com")

    traynews = factory.create_tray("新聞")

    traynews.add(asahi)
    traynews.add(yomiuri)

    trayyahoo = factory.create_tray("新聞")
    trayyahoo.add(us_yahoo)
    trayyahoo.add(jp_yahoo)

    traysearch = factory.create_tray("新聞")
    traysearch.add(trayyahoo)
    traysearch.add(excite)
    traysearch.add(google)

    page = factory.create_page("LinkPage", "結城　浩")
    page.add(traynews)
    page.add(traysearch)

    page.output
  end

  def usage
    puts "ちがうにゃ"
  end
end

Main.new.main(ARGV)
