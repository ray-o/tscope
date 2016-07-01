class Keyword < ActiveRecord::Base
  has_many :tweets
  mount_uploader :image, ImageUploader

  def grab_tweets
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end

    client.search(self.word, count: 150, result_type: "recent").take(150).collect do |tweet|
      new_tweet = Tweet.new

      new_tweet.tweet_id = tweet.id.to_s
      new_tweet.tweet_created_at = tweet.created_at
      new_tweet.text = tweet.text

      new_tweet.user_uid = tweet.user.id
      new_tweet.user_name = tweet.user.name
      new_tweet.user_screen_name = tweet.user.screen_name
      new_tweet.user_image_url = tweet.user.profile_image_url

      new_tweet.keyword = self

      new_tweet.save

    end
  end

  def self.grab_all_tweets
      Keyword.all.each(&:grab_tweets)

  end
end
