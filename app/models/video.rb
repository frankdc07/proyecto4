class Video
  include Mongoid::Document
  include Mongoid::Paperclip
  include Mongoid::Timestamps

  field :filename,   type: String
  field :description,   type: String
  field :status,   type: String
  field :link_original,   type: String
  field :link_converted,   type: String
  field :thumbnail,   type: String
  field :user_name,   type: String
  field :user_lastname,   type: String
  field :user_email,   type: String
  field :user_comments,   type: String
  field :contest,   type: String

  belongs_to :contest

  has_mongoid_attached_file :link_original
  has_mongoid_attached_file :link_converted
  has_mongoid_attached_file :thumbnail, styles: { medium_nr: "250x150!" }

  validates_attachment_content_type :link_original, content_type: /\Avideo/
  validates_attachment_content_type :link_converted, content_type: /.*/

  validates_attachment_presence :link_original

  #Video in process once uploaded
  def run_upload!
  	self.status = 'En Proceso'
  	save
  end

  # Publish video makes it available
  def process!
    self.status = 'Generado'
    save
  end

  # Checks if all formats are already encoded, the simplest way
  def all_formats_encoded?
    self.status=='Generado' ? true : false
  end

  #after_create :run_upload!

  #after_create :run_encoder

  private
  
  def run_encoder
    VideoProcessorJob.perform_later
  end  
  
end
