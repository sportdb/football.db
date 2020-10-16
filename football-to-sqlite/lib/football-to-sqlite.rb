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

  ## todo/fix: make sure path exists
  SportDb.connect( adapter: 'sqlite3',
                    database: dbpath )

  ## todo/fix: auto-migrate !!!!
  SportDb.create_all
  LogDb.setup  # start logging to db (that is, save logs in logs table in db)
end


def run( args )

  puts "-- optparse:"
  opts = {}
  optparser = OptionParser.new do |parser|
    parser.banner = "Usage: football-to-sqlite [options] database PATH"

    # parser.on( "-d", "--download", "Download web pages" ) do |download|
    #  opts[:download] = download
    # end

    # parser.on( "-p", "--push", "(Commit &) push changes to git" ) do |push|
    #  opts[:push] = push
    # end

  end
  optparser.parse!( args )

  puts "opts:"
  p opts
  puts "args:"
  p args

  puts "-------"
  puts
  dbpath = args.shift
  puts "dbpath: >#{dbpath}<"
  puts "args:"
  p args

  connect( dbpath )

  args.each do |arg|
    puts "reading #{arg}..."
    SportDb.read( arg )
  end

  puts "Done."
end # method run


end  # class Tool


  def self.main( args=ARGV ) Tool.new.run( args ); end
end  # module FootballToSqlite




puts SportDb::Module::FootballToSqlite.banner   # say hello
