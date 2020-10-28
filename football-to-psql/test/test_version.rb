###
#  to run use
#     ruby -I ./lib -I ./test test/test_version.rb


require 'helper'

class TestVersion < MiniTest::Test

  def test_version
    puts SportDb::Module::FootballToPsql.banner
    puts SportDb::Module::FootballToPsql.root
    puts SportDb::Module::FootballToPsql::VERSION
  end

end # class TestVersion

