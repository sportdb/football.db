$LOAD_PATH.unshift( "./lib" )
require 'football-to-psql'

args = [
  # 'england',
  # '..\..\..\openfootball\england\2020-21\1-premierleague.txt',
  # '..\..\..\openfootball\england\2020-21\2-championship.txt',
]

FootballToPsql.main( args )
