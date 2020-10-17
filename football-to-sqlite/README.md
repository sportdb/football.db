# football-to-sqlite - load / read football.txt datafiles into a sqlite database


* home  :: [github.com/sportdb/football.db](https://github.com/sportdb/football.db)
* bugs  :: [github.com/sportdb/football.db/issues](https://github.com/sportdb/football.db/issues)
* gem   :: [rubygems.org/gems/football-to-sqlite](https://rubygems.org/gems/football-to-sqlite)
* rdoc  :: [rubydoc.info/gems/football-to-sqlite](http://rubydoc.info/gems/football-to-sqlite)
* forum :: [opensport](http://groups.google.com/group/opensport)



## Usage


Run this tool against match files in the Football.TXT format like so:

```
$ football-to-sqlite england.db 2020-21\1-premierleague.txt
```

or pass in more than one match file:

```
$ football-to-sqlite england.db 2020-21\1-premierleague.txt \
                                2020-21\2-championship.txt  \
                                2020-21\3-league1.txt       \
                                2020-21\4-league2.txt       \
                                2020-21\5-nationalleague.txt
```


Note: If the single-file SQLite database (and its tables, views & indices) do not (yet) exist, they get auto-created on the first run.


Note: You can use `football2sqlite` as an alias / alternate name.


**Pipes & Standard Input (STDIN)**

You can use any command line tool to download match files and pipe (via stdin) into this tool like so:

```
$ curl https://raw.githubusercontent.com/openfootball/world-cup/master/2018--russia/cup.txt | football-to-sqlite worldcup.db
```

That's it for now.




## Limitations

Note: For now you CANNOT update match files, that is,
if you try to add the same match twice (assuming with updated scores or such), the match reader will fail for now.
The workaround is to always re-create/re-build your database from zero / scratch for now.



## Datasets

For some open public domain Football.TXT datasets to get started, see the [open football org](https://github.com/openfootball).


Add your datasets here!



## Installation

Use

    gem install football-to-sqlite

or add the gem to your Gemfile

    gem 'football-to-sqlite'


## License

The `football-to-sqlite` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the
[Open Sports & Friends Forum/Mailing List](http://groups.google.com/group/opensport).
Thanks!

