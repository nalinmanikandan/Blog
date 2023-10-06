class AddUserIdToTopics < ActiveRecord::Migration[7.0]
  def change
    add_reference :topics, :user, null: true, foreign_key: true
  end
end
