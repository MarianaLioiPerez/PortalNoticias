class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :news, foreign_key: true

      t.timestamps
    end
  end
end
