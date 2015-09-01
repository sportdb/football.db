# encoding: utf-8

require 'json'
require 'pp'

require 'textutils'

text = File.read_utf8( './squads.json' )

clubs = JSON.parse( text )

## pp h

COUNTRY_CODE = {
  ## europe
  'Deutschland' => 'GER',
  'Österreich'  => 'AUT',
  'Dänemark'    => 'DEN',
  'Slowenien'   => 'SVN',
  'Slowakei'    => 'SVK',
  'Polen'       => 'POL',
  'Albanien'    => 'ALB',
  'Serbien'     => 'SRB',
  'Norwegen'    => 'NOR',
  'Frankreich'  => 'FRA',
  ## asia
  'Japan'       => 'JPN',

 "Italien"=>"ITA",
 "Chile"=>"CHI",
 "Nigeria"=>"NGA",
 "Portugal"=>"POR",
 "Schweden"=>"SWE",
 "Spanien"=>"ESP",
 "Kolumbien"=>"COL",
 "Schweiz"=>"SUI",
 "Bulgarien"=>"BUL",
 "Argentinien"=>"ARG",
 "USA"=>"USA",
 "Kroatien"=>"CRO",
 "Brasilien"=>"BRA",
 "Griechenland"=>"GRE",
 "Türkei"=>"TUR",
 "Südkorea"=>"KOR",
 "Ukraine"=>"UKR",
 "Mexiko"=>"MEX",
 "Marokko"=>"MAR",
 "Niederlande"=>"NED",
 "Belgien"=>"BEL",
 "Guinea"=>"GUI",
 "Armenien"=>"ARM",
 "Gabun"=>"GAB",
 "Finnland"=>"FIN",
 "Aserbaidschan"=>"AZE",
 "Peru"=>"PER",
 "Elfenbeinküste"=>"CIV",
 "Tschechien"=>"CZE",
 "Ghana"=>"GHA",
 "Estland"=>"EST",
 "Paraguay"=>"PAR",
 "Kasachstan"=>"KAZ",
 "Kamerun"=>"CMR",
 "Israel"=>"ISR",
 "Australien"=>"AUS",
 "Bosnien-Herzegowina"=>"BIH",
 "Mosambik"=>"MOZ",
 "Ungarn"=>"HUN",
 "Lettland"=>"LTU",
 "Senegal"=>"SEN",
 "Tunesien"=>"TUN",
 "Costa Rica"=>"CRC",
 "Ecuador"=>"ECU",
 "Rumänien"=>"ROU",
 "DR Kongo"=>"COD",
}


CLUB_KEY = {
  '1. FC Köln'           => 'koeln',
  '1. FSV Mainz 05'      => 'mainz',
  'Bayer 04 Leverkusen'  => 'leverkusen',
  'Bayern München'       => 'bayern',
  'Bor. Mönchengladbach' => 'mgladbach',
  'Borussia Dortmund'    => 'dortmund',
  'Eintracht Frankfurt'  => 'frankfurt',
  'FC Augsburg'          => 'augsburg',
  'FC Ingolstadt 04'     => 'ingolstadt',
  'FC Schalke 04'        => 'schalke',
  'Hamburger SV'         => 'hsv',   ## change to hamburg!!
  'Hannover 96'          => 'hannover',
  'Hertha BSC'           => 'herthabsc',
  'SV Darmstadt 98'      => 'darmstadt',
  'TSG Hoffenheim'       => 'hoffenheim',
  'VfB Stuttgart'        => 'stuttgart',
  'VfL Wolfsburg'        => 'wolfsburg',
  'Werder Bremen'        => 'bremen'
}


MISSING_COUNTRIES = {}

def gen_squad( club, h )
  buf = ''
  buf << "###########################\n"
  buf << "#  #{club}\n"
  buf << "\n"

  last_position = ''
  h.each do |(k,v)|
    num       = v['number']
    birthdate = v['birthdate']
    name      = k
    position  = v['position']
    country   = v['country']
    cc  = COUNTRY_CODE[country]
    if cc.nil?
      puts "*** warn: no country code found for #{country}"
      if MISSING_COUNTRIES[country].nil?
        MISSING_COUNTRIES[country] = ''
      end
      cc = '???'
    end


    if last_position != position
      buf << "\n"
    end

    buf << "%2s  " % num
    if cc == "GER"
      buf << "%-33s  " % name      ## do NOT include country code for "natives"
    else
      buf << "%-33s  " % ("#{name} (#{cc})")
    end

    buf << "%s    " % position
    buf << "# %s"  % birthdate
    buf << "\n"
    
    last_position = position
  end
  buf
end



SORT_POSITION = {
  'GK' => 0,
  'DF' => 1,
  'MF' => 2,
  'FW' => 3,
}


###
## missing nummber is xx  -- what to do? set to ? or empty string ???


clubs.each_with_index do |(k,v), i|
  club       = k
  players    = v

  players = players.sort do |l,r|
    ## note gets us an array e.g.
    ##   ["Osako, Yuya", {"birthdate"=>"18.05.1990", "country"=>"Japan", "number"=>"13", "position"=>"FW"}]
    ##  e.g. l[0] is the key; l[1] is the value e.g. hash
    lpos = l[1]['position']   
    rpos = r[1]['position']

    value =  SORT_POSITION[lpos] <=> SORT_POSITION[rpos]
    value =  l[1]['number'].to_i <=> r[1]['number'].to_i    if value == 0
    value
  end
  players = players.to_h  # "convert" it back (after sorting) into an hash
  ##  pp players
  
  puts "*** #{club}"
  
  txt = gen_squad( club, players )
  puts txt
end

pp MISSING_COUNTRIES

