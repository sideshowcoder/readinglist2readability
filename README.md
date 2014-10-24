# Safari Readinglist (Bookmarks) to Readability Importer

Import all your Safari Bookmarks including the Reading List into Readability.

[Find it hosted on Heroku](http://readinglist2readability.herokuapp.com) for all
your importing needs.

## Install

    $ git clone https://github.com/sideshowcoder/readinglist2readability
    $ cd readinglist2readability && bundle install
    $ cp sample.env .env

## Local setup

On Readability create the needed [API
Keys](https://www.readability.com/settings/account) and fill into ```.env``` as
the first 3 entries

    CONSUMER_KEY=your-reader-api-key
    CONSUMER_SECRET=your-reader-api-secret
    PARSER_TOKEN=your-parser-token

with this in place you can run the app via

    $ rake development:server

and visit [localhost:3000](http://localhost:3000), and follow the instructions

## License
MIT

