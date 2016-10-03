require "sinatra"
require "exifr"

get "/" do
  erb :index
end

post "/upload" do
  if params[:file]
    file = EXIFR::JPEG.new(params[:file][:tempfile].path)
    @latitude = file.gps.latitude
    @longitude = file.gps.longitude
  end
  erb :upload
end
