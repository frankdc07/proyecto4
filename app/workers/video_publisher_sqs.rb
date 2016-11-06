class VideoPublisherSQS
  include Shoryuken::Worker

  shoryuken_options queue: 'smart_tools_convert_video', auto_delete: true

  def perform (sqs_msg, body)
  
    VideoProcessorJobSQS.perform_now(sqs_msg, body)
	
  end
end
