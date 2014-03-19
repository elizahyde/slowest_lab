class AddFollowsIndexestoFollows < ActiveRecord::Migration
  def change
    add_index :follows, :follower_id
    add_index :follows, :followed_id
  end
end
