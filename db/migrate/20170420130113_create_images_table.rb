class CreateImagesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :image
      t.belongs_to :item, index: true
    end
  end

  remove_column :items, :pictures, :json
end
