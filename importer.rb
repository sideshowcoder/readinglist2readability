require "bundler/setup"
require "readit"
require "ruby-progressbar"

require "dotenv"
Dotenv.load

Readit::Config.consumer_key = ENV["CONSUMER_KEY"]
Readit::Config.consumer_secret = ENV["CONSUMER_SECRET"]
Readit::Config.parser_token = ENV["PARSER_TOKEN"]

class SafariBookmarks
  def bookmarks
    @bookmarks ||= generate_bookmark_list
  end

  def reset
    @bookmarks = nil
  end

  def generate_bookmark_list
    raw_bookmarks = `/usr/bin/plutil -convert xml1 -o - ~/Library/Safari/Bookmarks.plist`
    bookmarks = []
    raw_bookmarks.scan(/<string>(http(s)?:\/\/.*)<\/string>/) do |m|
      bookmarks << m[0] unless m[0].include? "icloud"
    end
    bookmarks
  end
end


class ReadabilityBookmarks
  def initialize tokens
    @tokens = tokens
  end

  def api
    @api ||= Readit::API.new(@tokens[:token], @tokens[:secret])
  end

  def import_bulk bookmarks
    pb = ProgressBar.create(title: "Importing #{bookmarks.count} Bookmarks", total: bookmarks.count)
    bookmarks.map do |b|
      api.bookmark url: bookmark
      pb.increment
    end
  end
end

readbility= ReadabilityBookmarks.new(token: ENV["TOKEN"], secret: ENV["SECRET"])
bookmarks = SafariBookmarks.new.bookmarks
readbility.import_bulk bookmarks
