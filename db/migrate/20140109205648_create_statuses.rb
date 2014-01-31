class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name

      t.timestamps
    end

    Status.reset_column_information
  	Status.create(name: 'Registered')
  	Status.create(name: 'Approved')
  	Status.create(name: 'Passed')
  	Status.create(name: 'Failed')
  	Status.create(name: 'Undebated')
  end
end
