class CreateFollowings < ActiveRecord::Migration[6.1]
  def change
    create_table :followings do |t|
      t.bigint :follower_id
      t.bigint :followed_id

      t.timestamps
    end
  end
end
