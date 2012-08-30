class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body
      t.references :memolist

      t.timestamps
    end
    add_index :comments, :memolist_id
  end
end
