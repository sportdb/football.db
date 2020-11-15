
module FootballCat
class Tool


def initialize
end


def run( args )

  options = {}
  optparser = OptionParser.new do |parser|
    parser.banner = "Usage: football-cat [options] OUTPATH INPATHS..."
  end
  optparser.parse!( args )

  if args.empty?
    puts "!! ERROR - football.csv name/path expected (e.g. league.csv)"
    puts optparser.help
    exit 1
  end

  outpath = args.shift
  puts "outpath: >#{outpath}<"
  puts "args:"
  p args

  headers = nil

  args.each do |arg|
    inpath = File.expand_path( arg )
    puts "reading #{inpath}..."

    if File.directory?( inpath )
      pack = SportDb::DirPackage.new( inpath )
      pack.each_csv do |entry|
        puts "  #{entry.name}"

        basename = File.basename( entry.name, File.extname( entry.name ) )  ## get basename WITHOUT extension

        ## note: upcase for now and remove dots e.g.
        ##   es.1  => ES1
        ##   de.cup => DECUP    - why? why not?
        league_key = basename.upcase.gsub( '.', '' )

        ## todo/fix: check if season_key is proper season - e.g. matches pattern !!!!
        season_q   = File.basename( File.dirname( entry.name ))
        season     = Season.parse( season_q )  ## normalize season
        season_key = season.key

        puts "    league: #{league_key}, season: #{season_key}"

        txt = entry.read
        ## matches = SportDb::CsvMatchParser.parse( txt )
        rows = CsvHash.parse( txt )
        puts "    addinging #{rows.size} match(es)..."
        # rows = rows.map do |row|
        #                    { 'League' => league_key,
        #                      'Season' => season_key }.merge( row )
        #                end
        # pp rows[0..2]

        if headers.nil?
          ## first time - create file with headers
          headers = ['League', 'Season'] + rows[0].keys
          puts "headers:"
          pp headers

          FileUtils.mkdir_p( File.dirname( outpath ))  ## make sure path exists
          File.open( outpath, 'w:utf-8' ) do |f|
            f.write( headers.join(',') )
            f.write( "\n" )
          end
        end

        File.open( outpath, 'a:utf-8' ) do |f|
          rows.each do |row|
            f.write( csv_encode( [ league_key, season_key ] + row.values ))
            f.write( "\n")
          end
        end
      end
    else ## assume "free-standing" single datatfile
       puts "!! WARN - skipping datafile >#{inpath}< - sorry - for now only directories / packages work"
    end
  end


  puts "Done."
end # method run

##########
# helpers
def csv_encode( values )
  ## quote values that incl. a comma
  values.map do |value|
    if value.index(',')
      puts "** rec with field with comma:"
      pp values
      %Q{"#{value}"}
    else
      value
    end
  end.join( ',' )
end


end  # class Tool


def self.main( args=ARGV )
  Tool.new.run( args )
end
end  # module FootballCat
