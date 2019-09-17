class AddInfoToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_reference :answers, :info, foreign_key: true
  end
end
