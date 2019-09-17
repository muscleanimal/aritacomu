class CreateMentions < ActiveRecord::Migration[5.2]
  def change
    create_table :mentions do |t|
      t.string :comment
      t.references :user, foreign_key: true
      t.references :work, foreign_key: true

      t.timestamps
    end
  end
end
