if !current_user.nil?
  json.current_user do
    json.id current_user.id
    json.name current_user.name
    json.email current_user.email
    json.microposts_count current_user.microposts.count
    json.avatar "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(User.find(current_user.id).email.downcase)}"
    json.followers current_user.followers.count
    json.following current_user.following.count
  end
else 
  current_user nil
end