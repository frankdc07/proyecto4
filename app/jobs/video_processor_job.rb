class VideoProcessorJob < ApplicationJob

  queue_as :default

  def perform
    # Do something later

    ## aca incluir run encoder 

	#puts "Encoder.entre"
    
    #lst_videos = Video.where(status is not true)

    # Convertir cada video en la lista

   	Video.where(status: 'En Proceso').find_each do |video|
	    path_original = video.link_original.path
	    if !path_original.nil? 

		#path_converted = video.link_converted.path
		#output =  path_original + "#{Time.now.getutc.to_f.to_s.delete('.')}.mp4"
		output =  path_original.delete('.') + "_gen" + ".mp4"
		outthumbnail = path_original.delete('.') + "_th" + ".png"

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
			NotificationMailer.notificate(video).deliver
		else
			raise $?
		end
	   end
	end 
  end
end
