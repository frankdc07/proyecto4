# Be sure to restart your server when you modify this file.

#Rails.application.config.session_store :cookie_store, key: '_vContest_session'
Rails.application.config.session_store :redis_store, servers: "redis://stools-cache.rmatz6.0001.usw2.cache.amazonaws.com:6379/0/session"
