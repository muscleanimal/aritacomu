class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.references :user, foreign_key: true
      t.references :share, foreign_key: true
      t.string :comments

      t.timestamps
    end
  end
end
