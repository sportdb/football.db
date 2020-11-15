$LOAD_PATH.unshift( "./lib" )
require 'football-cat'

args = [
  'tmp/liga.csv',
  '..\..\..\footballcsv\espana',
  # '..\..\..\openfootball\england\2020-21\2-championship.txt',
]

FootballCat.main( args )
