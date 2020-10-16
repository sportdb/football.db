$LOAD_PATH.unshift( "./lib" )
require 'football-to-sqlite'

args = [
  'tmp/england.db',
  '..\..\..\openfootball\england\2020-21\1-premierleague.txt',
  # ..\..\..\openfootball\england\2020-21\2-championship.txt',
]

FootballToSqlite.main( args )
