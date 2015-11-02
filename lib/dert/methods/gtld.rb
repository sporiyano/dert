module Dert
  class GTLD

    @res = Dnsruby::Resolver.new

    def self.query(domain)
      results = []

      # List from:
      # http://data.iana.org/TLD/tlds-alpha-by-domain.txt

      tlds = %w(
                aaa abb abbott abogado ac academy accenture accountant accountants aco active actor ad ads adult
                ae aeg aero af afl ag agency ai aig airforce airtel al allfinanz alsace am amica amsterdam android
                ao apartments app aq aquarelle ar aramco archi army arpa arte as asia associates at attorney au auction
                audio auto autos aw ax axa az azure ba band bank bar barcelona barclaycard barclays bargains bauhaus
                bayern bb bbc bbva bcn bd be beer bentley berlin best bet bf bg bh bharti bi bible bid bike bing bingo
                bio biz bj black blackfriday bloomberg blue bm bms bmw bn bnl bnpparibas bo boats bom bond boo boots
                boutique br bradesco bridgestone broker brother brussels bs bt budapest build builders business buzz
                bv bw by bz bzh ca cab cafe cal camera camp cancerresearch canon capetown capital car caravan cards
                care career careers cars cartier casa cash casino cat catering cba cbn cc cd ceb center ceo cern cf
                cfa cfd cg ch chanel channel chat cheap chloe christmas chrome church ci cipriani cisco citic city ck
                cl claims cleaning click clinic clothing cloud club clubmed cm cn co coach codes coffee college cologne
                com commbank community company computer condos construction consulting contractors cooking cool coop
                corsica country coupons courses cr credit creditcard cricket crown crs cruises csc cu cuisinella cv cw
                cx cy cymru cyou cz dabur dad dance date dating datsun day dclk de deals degree delivery dell delta
                democrat dental dentist desi design dev diamonds diet digital direct directory discount dj dk dm dnp do
                docs dog doha domains doosan download drive durban dvag dz earth eat ec edu education ee eg email emerck
                energy engineer engineering enterprises epson equipment er erni es esq estate et eu eurovision eus events
                everbank exchange expert exposed express fage fail faith family fan fans farm fashion feedback fi film
                final finance financial firmdale fish fishing fit fitness fj fk flights florist flowers flsmidth fly fm
                fo foo football forex forsale forum foundation fr frl frogans fund furniture futbol fyi ga gal gallery
                game garden gb gbiz gd gdn ge gea gent genting gf gg ggee gh gi gift gifts gives giving gl glass gle
                global globo gm gmail gmo gmx gn gold goldpoint golf goo goog google gop gov gp gq gr graphics gratis
                green gripe group gs gt gu gucci guge guide guitars guru gw gy hamburg hangout haus healthcare help here
                hermes hiphop hitachi hiv hk hm hn hockey holdings holiday homedepot homes honda horse host hosting hoteles
                hotmail house how hr hsbc ht hu hyundai ibm icbc ice icu id ie ifm iinet il im immo immobilien in
                industries infiniti info ing ink institute insure int international investments io ipiranga iq ir irish
                is ist istanbul it itau iwc jaguar java jcb je jetzt jewelry jlc jll jm jo jobs joburg jp jprs juegos
                kaufen kddi ke kg kh ki kia kim kinder kitchen kiwi km kn koeln komatsu kp kr krd kred kw ky kyoto kz la
                lacaixa lancaster land landrover lasalle lat latrobe law lawyer lb lc lds lease leclerc legal lexus lgbt
                li liaison lidl life lighting limited limo linde link live lixil lk loan loans lol london lotte lotto
                love lr ls lt ltd ltda lu lupin luxe luxury lv ly ma madrid maif maison man management mango market
                marketing markets marriott mba mc md me media meet melbourne meme memorial men menu meo mg mh miami
                microsoft mil mini mk ml mm mma mn mo mobi moda moe moi mom monash money montblanc mormon mortgage
                moscow motorcycles mov movie movistar mp mq mr ms mt mtn mtpc mtr mu museum mutuelle mv mw mx my mz na
                nadex nagoya name navy nc ne nec net netbank network neustar new news nexus nf ng ngo nhk ni nico ninja
                nissan nl no nokia np nr nra nrw ntt nu nyc nz obi office okinawa om omega one ong onl online ooo oracle
                orange org organic osaka otsuka ovh pa page panerai paris partners parts party pe pet pf pg ph pharmacy
                philips photo photography photos physio piaget pics pictet pictures ping pink pizza pk pl place play
                plumbing plus pm pn pohl poker porn post pr praxi press pro prod productions prof properties property
                protection ps pt pub pw py qa qpon quebec racing re realtor realty recipes red redstone rehab reise
                reisen reit ren rent rentals repair report republican rest restaurant review reviews rich ricoh rio rip
                ro rocks rodeo rs rsvp ru ruhr run rw rwe ryukyu sa saarland sakura sale samsung sandvik sandvikcoromant
                sanofi sap sapo sarl saxo sb sbs sc sca scb schmidt scholarships school schule schwarz science scor scot
                sd se seat security seek sener services seven sew sex sexy sg sh shiksha shoes show shriram si singles
                site sj sk ski sky skype sl sm sn sncf so soccer social software sohu solar solutions sony soy space
                spiegel spreadbetting sr srl st stada starhub statoil stc stcgroup stockholm studio study style su sucks
                supplies supply support surf surgery suzuki sv swatch swiss sx sy sydney systems sz taipei tatamotors
                tatar tattoo tax taxi tc td team tech technology tel telefonica temasek tennis tf tg th thd theater
                theatre tickets tienda tips tires tirol tj tk tl tm tn to today tokyo tools top toray toshiba tours town
                toyota toys tr trade trading training travel trust tt tui tv tw tz ua ubs ug uk university uno uol us uy
                uz va vacations vc ve vegas ventures versicherung vet vg vi viajes video villas vin virgin vision vista
                vistaprint viva vlaanderen vn vodka vote voting voto voyage vu wales walter wang watch webcam website
                wed wedding weir wf whoswho wien wiki williamhill win windows wine wme work works world ws wtc wtf xbox
                xerox xin xn--11b4c3d xn--1qqw23a xn--30rr7y xn--3bst00m xn--3ds443g xn--3e0b707e xn--3pxu8k xn--42c2d9a
                xn--45brj9c xn--45q11c xn--4gbrim xn--55qw42g xn--55qx5d xn--6frz82g xn--6qq986b3xl xn--80adxhks
                xn--80ao21a xn--80asehdb xn--80aswg xn--90a3ac xn--90ais xn--9dbq2a xn--9et52u xn--b4w605ferd xn--c1avg
                xn--c2br7g xn--cg4bki xn--clchc0ea0b2g2a9gcd xn--czr694b xn--czrs0t xn--czru2d xn--d1acj3b xn--d1alf
                xn--efvy88h xn--estv75g xn--fhbei xn--fiq228c5hs xn--fiq64b xn--fiqs8s xn--fiqz9s xn--fjq720a xn--flw351e
                xn--fpcrj9c3d xn--fzc2c9e2c xn--gecrj9c xn--h2brj9c xn--hxt814e xn--i1b6b1a6a2e xn--imr513n xn--io0a7i
                xn--j1aef xn--j1amh xn--j6w193g xn--kcrx77d1x4a xn--kprw13d xn--kpry57d xn--kput3i xn--l1acc xn--lgbbat1ad8j
                xn--mgb9awbf xn--mgba3a3ejt xn--mgba3a4f16a xn--mgbaam7a8h xn--mgbab2bd xn--mgbayh7gpa xn--mgbbh1a71e
                xn--mgbc0a9azcg xn--mgberp4a5d4ar xn--mgbpl2fh xn--mgbx4cd0ab xn--mk1bu44c xn--mxtq1m xn--ngbc5azd xn--node
                xn--nqv7f xn--nqv7fs00ema xn--nyqy26a xn--o3cw4h xn--ogbpf8fl xn--p1acf xn--p1ai xn--pgbs0dh xn--pssy2u
                xn--q9jyb4c xn--qcka1pmc xn--rhqv96g xn--s9brj9c xn--ses554g xn--t60b56a xn--tckwe xn--unup4y
                xn--vermgensberater-ctb xn--vermgensberatung-pwb xn--vhquv xn--vuq861b xn--wgbh1c xn--wgbl6a xn--xhq521b
                xn--xkc2al3hye2a xn--xkc2dl3a5ee0h xn--y9a3aq xn--yfro4i67o xn--ygbi2ammx xn--zfr164b xperia xxx xyz
                yachts yamaxun yandex ye yodobashi yoga yokohama youtube yt za zara zip zm zone zuerich zw
              )

      target = domain.scan(/(\S*)[.]\w*\z/).join
      target.chomp!

      tlds.each do |a|
        # A
        begin
          ret = @res.query("#{target}.#{a}", Dnsruby::Types.A)
          ret.answer.each do |x|
            results << {
                address: x.address.to_s,
                type: x.type,
                hostname: x.name.to_s,
                ttl: x.ttl,
                klass: x.klass,
            }
          end
        rescue
          #
        end
      end
      results
    end
  end
end