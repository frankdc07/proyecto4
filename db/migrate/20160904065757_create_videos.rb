class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :filename
      t.text :description
      t.string :status
      t.attachment :link_original
      t.attachment :link_converted
      t.attachment :thumbnail
      t.string :user_name
      t.string :user_lastname
      t.string :user_email
      t.text :user_comments
      t.references :contest, foreign_key: true

      t.timestamps
    end
  end
end
