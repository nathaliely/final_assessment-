class AddPictureToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :picture, :json
  end
end
