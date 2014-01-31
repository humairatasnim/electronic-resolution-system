class CreateCommittees < ActiveRecord::Migration
  def change
    create_table :committees do |t|
      t.string :name

      t.timestamps
    end

    Committee.reset_column_information
    Committee.create(name: 'Advisory Panel')
	Committee.create(name: 'Disarmament Commission')
	Committee.create(name: 'ECOSOC ')
	Committee.create(name: 'Environment Commission')
	Committee.create(name: 'General Assembly 1')
	Committee.create(name: 'General Assembly 2')
	Committee.create(name: 'General Assembly 3')
	Committee.create(name: 'General Assembly 4')
	Committee.create(name: 'General Assembly 5')
	Committee.create(name: 'General Assembly 6')
	Committee.create(name: 'Human Rights Commission')
	Committee.create(name: 'Security Council')
	Committee.create(name: 'Special Conference 1')
	Committee.create(name: 'Special Conference 2')
  end
end
