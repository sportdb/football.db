require 'optparse'

require 'sportdb/readers'

require 'logutils/activerecord'   ## NOTE: check - add to/include in/move to sportdb/models



###
# our own code
require 'football-to-psql/version' # let version always go first


module FootballToPsql
class Tool

def initialize
  LogUtils::Logger.root.level = :info   # set logging level to info
end



def connect( dbconfig )
  puts "working directory: #{Dir.pwd}"

  SportDb.connect( dbconfig )

  SportDb.auto_migrate!

  LogDb.setup  # start logging to db (that is, save logs in logs table in db)
end



def run( args )
  dbconfig = {
    adapter:   'postgresql',
    encoding:  'unicode',
    username:  'postgres',
    password:  'postgres',
    host:      'localhost',
    port:      5432,
    database:  'sport.db',
    pool:       5,
    timeout:    5000
  }

  options = {}
  optparser = OptionParser.new do |parser|
    parser.banner = "Usage: football-to-psql [options] DATABASE PATHS..."

    parser.on( '-u', '--user USERNAME', '--username USERNAME',
                 "database username (default: #{dbconfig[:username]})" ) do |username|
      options[:username] = username
    end

    parser.on( '-p', '--password PASSWORD',
                 "database password (default: #{dbconfig[:password]})" ) do |password|
      options[:password] = password
    end

    parser.on( '-h', '--host HOST',
                 "database host (default: #{dbconfig[:host]})" ) do |host|
      options[:host] = host
    end

    parser.on( '--port PORT',
               "database port (default: #{dbconfig[:port]})" ) do |port|
      options[:port] = port
    end
  end
  optparser.parse!( args )

  if args.empty?
    puts "!! ERROR - postgresql database name expected (e.g. sport.db)"
    puts optparser.help
    exit 1
  end



  dbname = args.shift
  puts "dbname: >#{dbname}<"
  puts "args:"
  p args

  dbconfig[:database] = dbname

  dbconfig[:username] = options[:username]  if options[:username]
  dbconfig[:password] = options[:password]  if options[:password]
  dbconfig[:host]     = options[:host]      if options[:host]
  dbconfig[:port]     = options[:port]      if options[:port]

  connect( dbconfig )

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
end  # module FootballToPsql



puts SportDb::Module::FootballToPsql.banner   # say hello
