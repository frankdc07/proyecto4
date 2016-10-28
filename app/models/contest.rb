class Contest
  include Mongoid::Document
  include Mongoid::Paperclip
  include Mongoid::Timestamps
  
  field :title,   type: String
  field :banner
  field :url,   type: String
  field :date_ini,   type: Date
  field :date_end,   type: Date
  field :award,   type: String

  belongs_to :user
  has_many :videos, dependent: :destroy

  has_mongoid_attached_file :banner, styles: { medium_nr: "250x150!" }

  validates_attachment_content_type :banner, content_type: /\Aimage/

  validates_attachment_presence :banner

end
