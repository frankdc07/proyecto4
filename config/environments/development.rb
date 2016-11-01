Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    #config.cache_store = :memory_store
    #config.cache_store = :redis_store, "redis://stools-cache.rmatz6.0001.usw2.cache.amazonaws.com:6379/0/cache", { expires_in: 90.minutes }
    config.cache_store = :dalli_store,
                    (ENV["MEMCACHIER_SERVERS"] || "").split(","),
                    {:username => ENV["MEMCACHIER_USERNAME"],
                     :password => ENV["MEMCACHIER_PASSWORD"],
                     :failover => true,
                     :socket_timeout => 1.5,
                     :socket_failure_delay => 0.2,
                     :down_retry_delay => 60
                    }   
 
    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    }
    #config.action_dispatch.rack_cache = {
    #  metastore: "redis://stools-cache.rmatz6.0001.usw2.cache.amazonaws.com:6379/1/metastore",
    #  entitystore: "redis://stools-cache.rmatz6.0001.usw2.cache.amazonaws.com:6379/1/entitystore"
    #}
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.default_url_options = { host: 'ip-172-31-47-236.us-west-2.compute.internal:3000' }

  config.action_mailer.perform_caching = false

  config.action_mailer.delivery_method = :smtp
  # SMTP settings for gmail
  config.action_mailer.smtp_settings = {
    :address              => "email-smtp.us-west-2.amazonaws.com",
    :port                 => 587,
    :user_name            => ENV['username'],
    :password             => ENV['password'],
    :authentication       => "plain",
    :enable_starttls_auto => true
  }


  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  #config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  # config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.paperclip_defaults = {
    storage: :s3,
    s3_credentials: {
      bucket: ENV['S3_BUCKET_NAME'],
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      s3_region: ENV['AWS_REGION'],
    }
  }

  



end
