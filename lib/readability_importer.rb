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
    bookmark_infos = @bookmark_list.map do |bookmark|
      api.bookmark url: bookmark
    end

    bookmark_infos.inject({ success: 0, conflicts: 0, errors: 0 }) { |acc, info|
      case info[:status]
      when "202"
        acc[:success] += 1
      when "409"
        acc[:conflicts] += 1
      else
        acc[:errors] += 1
      end
      acc
    }
  end

  private
  def api
    @api ||= Readit::API.new(@tokens[:token], @tokens[:secret])
  end
end
