class AddImagesToInfos < ActiveRecord::Migration
  def self.up
    change_table :infos do |t|
      t.references :images, :polymorphic => true
    end
  end

  def self.down
    change_table :infos do |t|
      t.remove_references :images, :polymorphic => true
    end
  end
end
