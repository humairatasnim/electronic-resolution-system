class AddTitleToResolutions < ActiveRecord::Migration
  def change
    add_column :resolutions, :title, :string
  end
end
