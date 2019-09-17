class CreateRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :relations do |t|
      t.references :answer, foreign_key: true
      t.references :info, foreign_key: true

      t.timestamps
    end
  end
end
