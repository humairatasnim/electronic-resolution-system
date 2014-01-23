class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.references :conference
      t.integer :committee_id
      t.integer :user_id
      t.integer :status_id, :default => 1
      t.integer :votes_for
      t.integer :votes_against
      t.string :document_file_name
      t.string :document_content_type
      t.integer :document_file_size
      t.datetime :document_updated_at

      t.timestamps
    end
    add_index :resolutions, :conference_id
  end
end