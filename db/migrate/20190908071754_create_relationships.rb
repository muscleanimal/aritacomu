class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :info, foreign_key: true
      t.references :answer, foreign_key: true

      t.timestamps
    end
  end
end
