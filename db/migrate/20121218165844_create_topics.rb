class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.string :systematic_name

      t.timestamps
    end
  end
end
