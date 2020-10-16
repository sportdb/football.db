###
#  to run use
#     ruby -I ./lib -I ./test test/test_version.rb


require 'helper'

class TestVersion < MiniTest::Test

  def test_version
    puts SportDb::Module::FootballToSqlite.banner
    puts SportDb::Module::FootballToSqlite.root
    puts SportDb::Module::FootballToSqlite::VERSION
  end

end # class TestVersion

