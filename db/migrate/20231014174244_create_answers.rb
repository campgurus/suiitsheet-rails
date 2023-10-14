class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers, id: :uuid do |t|
      t.text :body
      t.boolean :approved
      t.references :question, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
