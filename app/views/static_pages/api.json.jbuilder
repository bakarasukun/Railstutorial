if !current_user.nil?
  json.items do
    json.array! @feed_items do |item|
      json.id item.id
      json.user_id item.user_id
      json.name User.find(item.user_id).name
      json.avatar "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(User.find(item.user_id).email.downcase)}?s=50"
      json.content item.content
      json.date time_ago_in_words(item.created_at)
      json.pic item.picture.url
    end
  end

  json.current_user do
    json.id current_user.id
    json.name current_user.name
    json.email current_user.email
    json.microposts_count current_user.microposts.count
    json.avatar "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(User.find(current_user.id).email.downcase)}"
    json.followers current_user.followers.count
    json.following current_user.following.count
  end
  json.page_count (current_user.feed.count.to_f / (30.to_f)).ceil
else 
  items []
  current_user nil
end