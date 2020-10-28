# football-to-psql - load / read football.txt datafiles into a postgresql database


* home  :: [github.com/sportdb/football.db](https://github.com/sportdb/football.db)
* bugs  :: [github.com/sportdb/football.db/issues](https://github.com/sportdb/football.db/issues)
* gem   :: [rubygems.org/gems/football-to-psql](https://rubygems.org/gems/football-to-psql)
* rdoc  :: [rubydoc.info/gems/football-to-psql](http://rubydoc.info/gems/football-to-psql)
* forum :: [opensport](http://groups.google.com/group/opensport)




## Usage

Try:

```
$ football-to-psql --help
```

printing:


```
Usage: football-to-psql [options] DATABASE PATHS...
    -u, --username USERNAME     database username (default: postgres)
    -p, --password PASSWORD     database password (default: postgres)
    -h, --host HOST             database host     (default: localhost)
```




Run this tool against match files (for clubs or national teams) in the Football.TXT format like so:

```
$ football-to-psql england.db 2020-21/1-premierleague.txt

# -or-

$ football-to-psql worldcup.db 2018--russia/cup.txt
```

or pass in more than one match file (e.g. different leagues or more seasons / years ):

```
$ football-to-psql england.db 2020-21/1-premierleague.txt  \
                              2020-21/2-championship.txt   \
                              2020-21/3-league1.txt        \
                              2020-21/4-league2.txt        \
                             2020-21/5-nationalleague.txt

# -or-

$ football-to-psql premier.db 2020-21/1-premierleague.txt  \
                              2019-20/1-premierleague.txt  \
                              2018-19/1-premierleague.txt  \
                              2017-18/1-premierleague.txt  \
                              2016-17/1-premierleague.txt

# -or-

$ football-to-psql worldcup.db 2018--russia/cup.txt                     \
                               2018--russia/cup_finals.txt              \
                               2014--brazil/cup.txt                     \
                               2014--brazil/cup_finals.txt              \
                               2010--south-africa/cup.txt               \
                               2010--south-africa/cup_finals.txt        \
                               2006--germany/cup.txt                    \
                               2006--germany/cup_finals.txt             \
                               2002--south-korea-n-japan/cup.txt        \
                               2002--south-korea-n-japan/cup_finals.txt \
                               1998--france/cup.txt                     \
                               1998--france/cup_finals.txt              \
                               1994--united-states/cup.txt              \
                              1994--united-states/cup_finals.txt
```


Note: If the PostgreSQL database (and its tables, views & indices) do not (yet) exist, they get auto-created / auto-migrated on the first run.


Note: You can use `football2psql` as an alias / alternate name.


**Pipes & Standard Input (STDIN)**

You can use any command line tool to download match files and pipe (via stdin) into this tool like so:

```
$ curl https://raw.githubusercontent.com/openfootball/world-cup/master/2018--russia/cup.txt | football-to-psql worldcup.db
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

    gem install football-to-psql

or add the gem to your Gemfile

    gem 'football-to-psql'


## License

The `football-to-psql` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the
[Open Sports & Friends Forum/Mailing List](http://groups.google.com/group/opensport).
Thanks!

