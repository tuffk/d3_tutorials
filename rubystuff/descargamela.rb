require 'open-uri'
countries = %w[israel mexico]
countries.each do |c|
  download = open("https://www.amcharts.com/lib/3/maps/svg/#{c}High.svg")
  IO.copy_stream(download, "#{c}.svg")
end
