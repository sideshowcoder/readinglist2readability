require "test_helper"
require "bookmark_list"

SAMPLE_DATA = File.read(File.expand_path "../fixtures/sample_bookmarks.xml", __FILE__)

describe BookmarkList do

  it "reads only the active readinglist links" do
    bookmark_list = BookmarkList.create_from_xml_export SAMPLE_DATA
    assert_equal bookmark_list.to_a.length, 8
  end

end
