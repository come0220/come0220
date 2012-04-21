class CreateMemodbs < ActiveRecord::Migration
  def change
    create_table :memodbs do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
