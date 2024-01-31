class CreateUsersBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :users_badges do |t|
      t.references :user, foreign_key: true, null: false
      t.references :badge, foreign_key: true, null: false

      t.timestamps
    end
  end
end
