require "forwardable"

class BookmarkList
  include Enumerable
  extend Forwardable

  def_delegator :@list, :each

  def initialize list
    @list = list
  end

  def self.create_from_xml_export raw_xml
    list = []
    raw_xml.scan(/<string>(http(s)?:\/\/.*)<\/string>/) do |m|
      list << m[0] unless m[0].include? "icloud"
    end
    new list
  end
end
