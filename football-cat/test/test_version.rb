###
#  to run use
#     ruby -I ./lib -I ./test test/test_version.rb


require 'helper'

class TestVersion < MiniTest::Test

  def test_version
    puts SportDb::Module::FootballCat.banner
    puts SportDb::Module::FootballCat.root
    puts SportDb::Module::FootballCat::VERSION
  end

end # class TestVersion

