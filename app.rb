require 'open-uri'
require 'json'

username = 'YumaYX'
url = "https://api.github.com/users/#{username}/repos"

doc = "<ul>"

begin
  response = URI.open(url).read
  repos = JSON.parse(response)
  repos.each do |repo|
    doc = doc + "<li><a href=\"#{repo['html_url']}\">#{repo['name']}</a></li>"     
  end
rescue OpenURI::HTTPError => e
  puts "Failed to fetch repositories: #{e.message}"
end

doc = doc + "</ul>"

File.write("_includes/ghrs.md",doc)
