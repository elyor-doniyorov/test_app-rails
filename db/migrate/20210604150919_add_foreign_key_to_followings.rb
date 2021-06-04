class AddForeignKeyToFollowings < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key "followings", "users", column: "followed_id"
    add_foreign_key "followings", "users", column: "follower_id"
  end
end
