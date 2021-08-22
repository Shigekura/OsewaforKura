class CreateKurarecords < ActiveRecord::Migration[5.2]
  def change
    create_table :kurarecords do |t|
      t.datetime :clock
      t.float :feed
      t.string :content
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
