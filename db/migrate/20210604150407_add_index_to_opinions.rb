class AddIndexToOpinions < ActiveRecord::Migration[6.1]
  def change
    add_index :opinions, :user_id
    add_index :opinions, :copied_id
  end
end
