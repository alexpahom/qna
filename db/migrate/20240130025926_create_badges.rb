class CreateBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :badges do |t|
      t.string :description
      t.references :question, foreign_key: true, null: false

      t.timestamps
    end
  end
end
