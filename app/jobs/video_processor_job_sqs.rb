class VideoProcessorJobSQS < ApplicationJob

  #queue_as :default

  def perform(msg, videoid)

    # Convertir video de la cola 

   	video = Video.find(videoid)
	if !video.nil?
	
	    domain = 'http://d1ox08cdj9olo7.cloudfront.net'
		path_original = domain + video.link_original.path
		
	  if !path_original.nil? 

		output =  'tmp/' + video.filename.gsub(/\s+/, "") + video.id.to_s + "_gen.mp4"
		outthumbnail = 'tmp/' + video.filename.gsub(/\s+/, "") + video.id.to_s + "_th.png"

		_command = `ffmpeg -i #{path_original} -f mp4 -vcodec h264 -acodec aac -strict -2 #{output}`
		_command = `ffmpeg -i #{path_original} -ss 00:00:01.000 -vframes 1 #{outthumbnail}`
			 
		if $?.to_i == 0
			f = File.open(output, 'r')
			th = File.open(outthumbnail, 'r')
			video.link_converted = f
			video.thumbnail = th
			video.save
			video.process!
			f.close
			th.close
			File.delete(output)
			File.delete(outthumbnail)
			#NotificationMailer.notificate(video).deliver
		else
			raise $?
		end
	  else
	    raise $?
	  end
	else
	  raise $?
	end 
  end
end
