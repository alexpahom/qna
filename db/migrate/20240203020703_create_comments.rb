class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :body

      t.belongs_to :author, foreign_key: { to_table: :users }, null: false
      t.belongs_to :commentable, polymorphic: true

      t.timestamps
    end
  end
end
