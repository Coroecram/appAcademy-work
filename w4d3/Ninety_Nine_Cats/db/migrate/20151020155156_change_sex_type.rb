class ChangeSexType < ActiveRecord::Migration
  def change
    change_column :cats, :sex, :text, :limit => 1
  end
end
