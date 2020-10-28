require 'optparse'

require 'sportdb/readers'

require 'logutils/activerecord'   ## NOTE: check - add to/include in/move to sportdb/models



###
# our own code
require 'football-to-sqlite/version' # let version always go first


module FootballToSqlite
class Tool

def initialize
  LogUtils::Logger.root.level = :info   # set logging level to info
end


def connect( dbpath )
  puts "working directory: #{Dir.pwd}"

  ## note:
  ##  File.dirname( 'test.db' ) returns '.'
  ##   thus, use expand_path first to get full path
  ##
  ## todo/check: move mkdir into connect (for (re)use) - why? why not?
  FileUtils.mkdir_p( File.dirname( File.expand_path( dbpath )))   ## make sure path exists

  SportDb.connect( adapter: 'sqlite3',
                   database: dbpath )

  SportDb.auto_migrate!

  LogDb.setup  # start logging to db (that is, save logs in logs table in db)
end


def run( args )

  options = {}
  optparser = OptionParser.new do |parser|
    parser.banner = "Usage: football-to-sqlite [options] DATABASE PATHS..."
  end
  optparser.parse!( args )

  if args.empty?
    puts "!! ERROR - sqlite database name/path expected (e.g. sport.db)"
    puts optparser.help
    exit 1
  end

  dbpath = args.shift
  puts "dbpath: >#{dbpath}<"
  puts "args:"
  p args

  connect( dbpath )

  args.each do |arg|
    puts "reading #{arg}..."
    ## note: only support reading matchfiles for now (NOT zips & dirs or clubs & leagues etc.)
    SportDb.read_match( arg )
  end

  ## todo: check if stdin is always utf-8 or such?
  unless STDIN.tty?
    puts "reading STDIN..."
    ## assume/ read stdin as utf8 - possible?
    txt = STDIN.read
    puts "[------------->>>"
    puts txt
    puts "<<<-------------]"
    SportDb.parse_match( txt )
    puts "encoding: #{txt.encoding}"
  end


  ## print some stats
  SportDb.tables

  puts "Done."
end # method run


end  # class Tool


  def self.main( args=ARGV ) Tool.new.run( args ); end
end  # module FootballToSqlite




puts SportDb::Module::FootballToSqlite.banner   # say hello
