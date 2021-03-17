class CreateFeeds < ActiveRecord::Migration[6.0]
  def change
    create_table :feeds do |t|
      t.string :url
      t.text :new_feed

      t.timestamps
    end
  end
end
