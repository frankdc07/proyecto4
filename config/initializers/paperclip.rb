Rails.application.config.before_initialize do
  Paperclip::Attachment.default_options[:url] = ':smarttoolsbucket.s3.amazonaws.com'

  Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
end

Paperclip::Attachment.default_options[:s3_host_name] = 's3-us-west-2.amazonaws.com'
Paperclip::Attachment.default_options[:s3_region] = 'us-west-2'
Paperclip::Attachment.default_options[:bucket] = 'smarttoolsbucket'