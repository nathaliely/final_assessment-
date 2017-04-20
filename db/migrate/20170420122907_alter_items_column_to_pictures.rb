class AlterItemsColumnToPictures < ActiveRecord::Migration[5.0]
  def change
    rename_column :items, :picture, :pictures
  end
end
