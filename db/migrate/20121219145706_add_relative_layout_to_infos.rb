class AddRelativeLayoutToInfos < ActiveRecord::Migration
  def up
    add_column :infos, :relative_layout, :integer, default:0
  end

  def down
    remove_column :infos, :relative_layout, :integer
  end

end
