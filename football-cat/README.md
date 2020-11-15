# football-cat - concatenate football.csv datafiles - make out of many, one


* home  :: [github.com/sportdb/football.db](https://github.com/sportdb/football.db)
* bugs  :: [github.com/sportdb/football.db/issues](https://github.com/sportdb/football.db/issues)
* gem   :: [rubygems.org/gems/football-cat](https://rubygems.org/gems/football-cat)
* rdoc  :: [rubydoc.info/gems/football-cat](http://rubydoc.info/gems/football-cat)
* forum :: [opensport](http://groups.google.com/group/opensport)



## Usage

Run this tool to concatenate match files (for clubs or national teams) in the one-line, one-match & one-file, one-season Football.CSV format
into one
PLUS (auto-)adding the missing league and season headers / columns
inferred from the file's basename (e.g. `es.1.csv` => `ES1`)
and the file's directory (e.g. `/2020-21/` => `2020/21`). Example:

```
$ football-cat espana.csv espana
```

Concatenates all match files in the `espana` directory
(and all its subdirectories) into the single-file `espana.csv`
plus (auto-)adding two new leading columns, that is, league and season.

```
/footballcsv/espana
├───2010s
│   ├───2012-13
│   │       es.1.csv
│   ├───2013-14
│   │       es.1.csv
│   ├───2014-15
│   │       es.1.csv
│   ├───2015-16
│   │       es.1.csv
│   ├───2016-17
│   │       es.1.csv
│   ├───2017-18
│   │       es.1.csv
│   ├───2018-19
│   │       es.1.csv
│   │       es.2.csv
│   └───2019-20
│           es.1.csv
│           es.2.csv
└───2020s
    └───2020-21
            es.1.csv
            es.2.csv
```

and looking into `2010s/2012-12/es.1.csv`, for example:

```
Round,Date,Team 1,FT,Team 2
1,Sat Aug 18 2012,RCD Mallorca,2-1,RCD Espanyol
1,Sat Aug 18 2012,Sevilla FC,2-1,Getafe CF
1,Sat Aug 18 2012,RC Celta Vigo,0-1,Málaga CF
1,Sun Aug 19 2012,Levante UD,1-1,Atlético Madrid
1,Sun Aug 19 2012,Real Madrid,1-1,Valencia CF
1,Sun Aug 19 2012,FC Barcelona,5-1,Real Sociedad
1,Sun Aug 19 2012,Athletic Club Bilbao,3-5,Real Betis
1,Mon Aug 20 2012,RCD La Coruña,2-0,CA Osasuna
1,Mon Aug 20 2012,Rayo Vallecano,1-0,Granada CF
1,Mon Aug 20 2012,Real Zaragoza,0-1,Real Valladolid CF
```

becomes the all-in-one `espana.csv`:

```
League,Season,Round,Date,Team 1,FT,Team 2
ES1,2012/13,1,Sat Aug 18 2012,RCD Mallorca,2-1,RCD Espanyol
ES1,2012/13,1,Sat Aug 18 2012,Sevilla FC,2-1,Getafe CF
ES1,2012/13,1,Sat Aug 18 2012,RC Celta Vigo,0-1,Málaga CF
ES1,2012/13,1,Sun Aug 19 2012,Levante UD,1-1,Atlético Madrid
ES1,2012/13,1,Sun Aug 19 2012,Real Madrid,1-1,Valencia CF
ES1,2012/13,1,Sun Aug 19 2012,FC Barcelona,5-1,Real Sociedad
ES1,2012/13,1,Sun Aug 19 2012,Athletic Club Bilbao,3-5,Real Betis
ES1,2012/13,1,Mon Aug 20 2012,RCD La Coruña,2-0,CA Osasuna
ES1,2012/13,1,Mon Aug 20 2012,Rayo Vallecano,1-0,Granada CF
ES1,2012/13,1,Mon Aug 20 2012,Real Zaragoza,0-1,Real Valladolid CF
...
ES2,2020/21,42,Sun May 30 2021,AD Alcorcón,,RCD Espanyol
ES2,2020/21,42,Sun May 30 2021,Albacete Balompié,,CF Fuenlabrada
ES2,2020/21,42,Sun May 30 2021,CD Mirandés,,CE Sabadell
ES2,2020/21,42,Sun May 30 2021,CD Tenerife,,Real Oviedo
ES2,2020/21,42,Sun May 30 2021,FC Cartagena,,Girona FC
ES2,2020/21,42,Sun May 30 2021,Málaga CF,,CD Castellón
ES2,2020/21,42,Sun May 30 2021,Rayo Vallecano,,CD Lugo
ES2,2020/21,42,Sun May 30 2021,Real Zaragoza,,CD Leganés
ES2,2020/21,42,Sun May 30 2021,SD Ponferradina,,RCD Mallorca
ES2,2020/21,42,Sun May 30 2021,Sporting Gijón,,UD Almería
ES2,2020/21,42,Sun May 30 2021,UD Logroñés,,UD Las Palmas
```


Note: You can pass along more than one directory to the tool.
Let's concatenate the top leagues from the football.csv org:

```
$ football-cat top.csv footballcsv/england     \
                       footballcsv/espana      \
                       footballcsv/deutschland
```


That's all for now. Happy data wrangling. Enjoy the beautiful game.


## Datasets

For some open public domain Football.CSV datasets to get started, see the [football.csv org](https://github.com/footballcsv).


Add your datasets here!



## Installation

Use

    gem install football-cat

or add the gem to your Gemfile

    gem 'football-cat'


## License

The `football-cat` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the
[Open Sports & Friends Forum/Mailing List](http://groups.google.com/group/opensport).
Thanks!

