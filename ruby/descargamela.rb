require 'open-uri'
require 'nokogiri'
require 'json'
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

json = File.open('bigjson.json', 'w+')
pathsJson = {}
files.each do |f|
  File.open(f, 'r') do |doc|
    name = File.basename(doc)
    pathsJson[name] = {}
    zone_cont = 0
    data = File.open(doc) { |fi| Nokogiri::XML(fi) }
    data.search('path').each do |elem|
      pathsJson[name][zone_cont.to_s] = {}
      title = elem['title']
      path = elem['d']
      pathsJson[name][zone_cont.to_s]['name'] = title
      pathsJson[name][zone_cont.to_s]['path'] = path
      zone_cont += 1
    end
  end
end

json << pathsJson.to_json
json.close
