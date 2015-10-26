class ChangeBandNametoTitle < ActiveRecord::Migration
  def change
    rename_column :bands, :name, :title
  end
end
