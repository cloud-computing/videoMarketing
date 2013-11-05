# Be sure to restart your server when you modify this file.

#VideoMarketing::Application.config.session_store :cookie_store, key: '_video_marketing_session'

# Now session stored with Dalli (Memcached), 20 minutes expiration
Rails.application.config.session_store ActionDispatch::Session::CacheStore, :expire_after => 20.minutes