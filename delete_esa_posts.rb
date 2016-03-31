require 'esa'

token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
team  = "xxxxxxxx"
user  = "xxxxxx"

client = Esa::Client.new(access_token: token, current_team: team)
posts = client.posts(q: "user:#{user}")

posts.body["posts"].each do |post|
  number = post["number"]
  create_user = post["created_by"]["screen_name"]
  if create_user == user
    res = client.delete_post(number)
  else
    puts "no post"
    break
  end
  if res.status == 204
    puts "Post no.#{number} has been deleted"
  else
    puts "Error: Status #{res.status}"
    break
  end
end
