class CreateQuestionsAndAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.text :body, null: false

      t.timestamps
    end

    create_table :answers do |t|
      t.text :body, null: false
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
