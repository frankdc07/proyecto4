# Be sure to restart your server when you modify this file.

#Rails.application.config.session_store :cookie_store, key: '_vContest_session'
Rails.application.config.session_store :redis_store, servers: "memcached-18437.c10.us-east-1-2.ec2.cloud.redislabs.com:18437/0/session"
#Rails.application.config.session_store ActionDispatch::Session::CacheStore, :expire_after => 20.minutes


