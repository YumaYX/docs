require 'open-uri'
require 'json'

username = 'YumaYX'
url = "https://api.github.com/users/#{username}/repos"

begin
  response = URI.open(url).read
  repos = JSON.parse(response)
  repos.each do |repo|
    puts "- [#{repo['name']}](#{repo['html_url']})"
  end
rescue OpenURI::HTTPError => e
  puts "Failed to fetch repositories: #{e.message}"
end
