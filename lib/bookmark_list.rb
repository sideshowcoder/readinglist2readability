require "forwardable"
require "plist"

class BookmarkList
  include Enumerable
  extend Forwardable

  def_delegator :@list, :each

  def initialize list
    @list = list
  end

  def self.create_from_xml_export raw_xml
    plist = Plist::parse_xml(raw_xml)
    new extract_urls_for_active_items(plist)
  end

  private
  def self.extract_urls_for_active_items plist
    plist
    .fetch("Children")                          # get the root object
    .select { |e| e["Children"] }               # get only items which are lists
    .flat_map { |e| e["Children"] }             # extract the children
    .select { |e|
      e["ReadingList"] &&                       # it needs to be a reading list
        e["URLString"] &&                       # it needs to have an URL
        e["ReadingList"]["DateLastViewed"].nil? # it is still active
    }
    .map { |e| e["URLString"] }                 # only need the URL
  end
end
