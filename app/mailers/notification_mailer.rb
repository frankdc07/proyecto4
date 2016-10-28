class NotificationMailer < ApplicationMailer

  default from: "jf.moreano89@uniandes.edu.co"

  def notificate(video)
  	@video = video
  	@contest = Contest.find(@video.contest_id)
  	mail(to: @video.user_email, subject: 'Your video was published!')
  end

end
