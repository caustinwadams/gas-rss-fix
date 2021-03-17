class AddTitleToFeeds < ActiveRecord::Migration[6.0]
  def change
    add_column :feeds, :title, :string
  end
end
