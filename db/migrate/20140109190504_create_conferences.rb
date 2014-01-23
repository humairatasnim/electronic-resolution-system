class CreateConferences < ActiveRecord::Migration
  def change
    create_table :conferences do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :admin_user_id

      t.timestamps
    end
  end
end
