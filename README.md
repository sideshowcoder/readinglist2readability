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

Now authorize with Readability Oauth to get a token and secret via the provided
sinatra app, by starting the app like this

    $ bundle exec rackup -p 4567

and visit [localhost:4567](http://localhost:4567), after login via Readability
is successful it will display the needed token and secret to be added to
```.env```

    TOKEN=your-oauth-token
    SECRET=you-oauth-secret

## Run
Running the importer will dump a list of all your Safari Bookmarks and Reading
list entires and add each of them to Readability. This can take a while!

    $ ruby importer.rb

Enjoy!

## License
MIT

