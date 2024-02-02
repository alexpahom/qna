class CreateRanks < ActiveRecord::Migration[6.1]
  def change
    create_table :ranks do |t|
      t.integer :value
      t.belongs_to :rankable, polymorphic: true
      t.belongs_to :author, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
