Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['WWD_FB_APP_ID'], ENV['WWD_FB_SECRET']
  provider :twitter, ENV['WWD_TWITTER_KEY'], ENV['WWD_TWITTER_SECRET']
end
