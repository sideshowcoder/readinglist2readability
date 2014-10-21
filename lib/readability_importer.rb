require "readit"

Readit::Config.consumer_key = ENV["CONSUMER_KEY"]
Readit::Config.consumer_secret = ENV["CONSUMER_SECRET"]
Readit::Config.parser_token = ENV["PARSER_TOKEN"]

class ReadabilityImporter
  def initialize tokens, bookmark_list
    @bookmark_list = bookmark_list
    @tokens = tokens
  end

  def import
    @bookmark_list.each { |bookmark| api.bookmark url: bookmark }
  end

  private
  def api
    @api ||= Readit::API.new(@tokens[:token], @tokens[:secret])
  end
end
