class Photos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :name
      t.text :img_url
      t.integer :user_id
    end
  end
end
