json.extract! news_post, :id, :name, :content, :user_id, :news_feed_id, :created_at, :updated_at
json.url news_post_url(news_post, format: :json)
