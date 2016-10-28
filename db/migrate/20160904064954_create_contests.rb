class CreateContests < ActiveRecord::Migration[5.0]
  def change
    create_table :contests do |t|
      t.string :title
      t.attachment :banner
      t.string :url
      t.datetime :date_ini
      t.datetime :date_end
      t.text :award
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
