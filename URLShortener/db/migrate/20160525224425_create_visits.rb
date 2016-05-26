class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :user_id, null: false
      t.integer :url_id, null: false
      t.timestamps
    end
    add_index :visits, :user_id, unique: true
    add_index :visits, :url_id, unique: true
  end
end
