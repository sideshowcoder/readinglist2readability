require "test_helper"
require "rack/test"
require "app"

describe "ReadingList2Readability" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "serves the main page" do
    get "/"
    assert_equal last_response.status, 200
  end
end
