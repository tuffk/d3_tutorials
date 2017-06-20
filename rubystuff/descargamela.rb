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
vagina = {}
files.each do |f|
  File.open(f, 'r') do |doc|
    name = File.basename(doc)
    vagina[name] = {}
    verga = 0
    data = File.open(doc) { |fi| Nokogiri::XML(fi) }
    data.search('path').each do |sharmuta|
      vagina[name][verga.to_s] = {}
      title = sharmuta['title']
      path = sharmuta['d']
      vagina[name][verga.to_s]['name'] = title
      vagina[name][verga.to_s]['path'] = path
      verga += 1
    end
  end
end
# vagina = {}
# files.each do |f|
#   File.open(f, 'r') do |doc|
#     country = File.basename(doc)
#     vagina[country] = {}
#     doc.each_line do |l|
#       if l.include? '<path'
#         pito = l.split(' ')
#         title = pito[2].tr('=', ':')
#         title.insert(0, '"')
#         title.insert(6, '"')
#         vagina[country]['name'] = title
#         vagina[country]['path'] = l
#       else
#         next
#       end
#     end
#   end
# end
json << vagina.to_json
