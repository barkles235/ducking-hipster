class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.string :title
      t.text :text
      t.integer :topic_id
      t.integer :child_of
      t.references :topic
      t.timestamps
    end
  end
end
