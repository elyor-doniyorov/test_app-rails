class CreateOpinions < ActiveRecord::Migration[6.1]
  def change
    create_table :opinions do |t|
      t.text :text
      t.integer :user_id
      t.integer :copied_id

      t.timestamps
    end
  end
end
