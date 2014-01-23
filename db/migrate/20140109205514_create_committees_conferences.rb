class CreateCommitteesConferences < ActiveRecord::Migration
  def change
    create_table :committees_conferences do |t|
      t.references :committee
      t.references :conference
    end
    add_index :committees_conferences, :committee_id
    add_index :committees_conferences, :conference_id
  end
end
