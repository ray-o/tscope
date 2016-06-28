class Keyword < ActiveRecord::Base
  has_many :tweets
  def grab_tweets
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "MnmDLJlwavmjwbCOQCyDr0VTb"
      config.consumer_secret     = "OjNQjxd158EiWYn1ZE75QWO5GuyPHjj89Yz6QLZzgUXtML5gui"
      config.access_token        = "2436707892-pwQHaoj9L7AG7e9GoE17hXiQOyDOZISOJbmIyac"
      config.access_token_secret = "gVG0ZXR5Fn36tXLt1TTManpNMLU8THFonMxi9HmCOjLw1"
    end

    client.search(self.word, count: 10, result_type: "recent").take(10).collect do |tweet|
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
end
