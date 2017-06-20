require 'open-uri'
require 'pry'
require 'pry-nav'
files = Dir['*.svg']
countries = %w[israel mexico]
num = 0
if files.empty?
  countries.each do |c|
    download = open("https://www.amcharts.com/lib/3/maps/svg/#{c}High.svg")
    IO.copy_stream(download, "#{c}.svg")
    num += 1
  end
  puts "#{num} files downloaded"
end
