class Keyword < ActiveRecord::Base
  def grab_tweets
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "MnmDLJlwavmjwbCOQCyDr0VTb"
      config.consumer_secret     = "OjNQjxd158EiWYn1ZE75QWO5GuyPHjj89Yz6QLZzgUXtML5gui"
      config.access_token        = "2436707892-pwQHaoj9L7AG7e9GoE17hXiQOyDOZISOJbmIyac"
      config.access_token_secret = "gVG0ZXR5Fn36tXLt1TTManpNMLU8THFonMxi9HmCOjLw1"
    end

    client.search(self.word, count: 3, result_type: "recent").take(3).collect do |tweet|
      "#{tweet.user.screen_name}: #{tweet.text}"
    end
  end
end
