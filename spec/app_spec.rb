ENV["RACK_ENV"] = "production"

require "./app"

describe "exifchan" do
  def app
    Sinatra::Application
  end
end

require File.dirname(__FILE__) + "/spec_helper"

describe "App" do
  include Rack::Test::Methods
  def app
    @app ||= Sinatra::Application
  end

  describe "Returning Result" do
    describe "Latitude / Longitude" do
      before { get '/upload' }
      subject { last_response }
      it "Return Latitude" do
        upload_file = File.dirname(__FILE__) + "/geo.jpg"
        post_file = Rack::Test::UploadedFile.new(upload_file)
        post "/upload","file" => post_file
        expect(last_response.body.include?("37.8571471299478")).to eq(true)
      end
      it "Return Longitude" do
        upload_file = File.dirname(__FILE__) + "/geo.jpg"
        post_file = Rack::Test::UploadedFile.new(upload_file)
        post "/upload","file" => post_file
        expect(last_response.body.include?("15.284353479992895")).to eq(true)
      end
    end
  end
end
