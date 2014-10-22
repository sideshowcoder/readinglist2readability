# Safari Readinglist (Bookmarks) to Readability Importer

Import all your Safari Bookmarks including the Reading List into Readability.

## Install

    $ git clone https://github.com/sideshowcoder/readinglist2readability
    $ cd readinglist2readability && bundle install
    $ cp sample.env .env

## Setup
On Readability create the needed [API
Keys](https://www.readability.com/settings/account) and fill into ```.env``` as
the first 3 entries

    CONSUMER_KEY=your-reader-api-key
    CONSUMER_SECRET=your-reader-api-secret
    PARSER_TOKEN=your-parser-token

with this in place you can run the app via

    $ bundle exec rackup -p 4567 -s thin

and visit [localhost:4567](http://localhost:4567), and follow the instructions

## License
MIT

