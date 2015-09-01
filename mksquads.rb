# encoding: utf-8

## stdlibs
require 'json'
require 'pp'

## 3rd party libs/gems
require 'textutils'

## our own code
require './countries'



################################
# note: for now "hard-coded" for de-deutschland/2015-16
#   make more "generic" as more import data gets used


text = File.read_utf8( './de-deutschland/2015-16/1-bundesliga-squads.json' )

clubs = JSON.parse( text )

## pp h

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
    since     = v['since']

    if num == 'xx'
      num = ''   # convert unknown number eg. xx to empty string
    end
    

    if country =~ /^[A-Z]{3}$/   ## three letter code use as is
      cc = country
    else
      cc  = COUNTRY_CODE[country]
      if cc.nil?
        puts "*** warn: no country code found for #{country}"
        if MISSING_COUNTRIES[country].nil?
          MISSING_COUNTRIES[country] = ''
        end
        cc = '???'
      end
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

    buf << "%s  " % position
    buf << "%s-       " % since
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

out_root = './build/de-deutschland'


clubs.each_with_index do |(k,v), i|
  club       = k
  club_key   = CLUB_KEY[ k ]
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
    
  out_path = "#{out_root}/#{club_key}.txt"
  out_dir  = File.dirname( out_path )

  puts "#{club_key} - #{out_path}"
  txt = gen_squad( club, players )
  puts txt

  ## make sure out_path exists
  ## make sure dest folder exists
  FileUtils.mkdir_p( out_dir ) unless Dir.exists?( out_dir )
  
  File.open( out_path, 'w' ) do |f|
    f.write txt
  end
end

pp MISSING_COUNTRIES

