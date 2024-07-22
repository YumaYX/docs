require 'net/http'
require 'json'

def get_github_repos(username)
  uri = URI("https://api.github.com/users/#{username}/repos?per_page=100")
  response = Net::HTTP.get_response(uri)

  if response.code == '200'
    JSON.parse(response.body)
  else
    puts "Failed to fetch repositories: #{response.code}"
    nil
  end
end

puts "\n\n# GitHub Repos\n\n"
repos = get_github_repos("YumaYX")
repos.sort_by { |repo| repo["name"].downcase }.each do |repo|
  puts "- [#{repo["name"]}](#{repo["html_url"]})"
end

