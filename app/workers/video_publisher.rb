class VideoPublisher
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely }

  def perform
    VideoProcessorJob.perform_now
  end
end
