class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :event_id
      t.string :date
      t.string :tag_line
      t.string :url
      t.string :artist
      t.references :user

      t.timestamps
    end
  end
end
