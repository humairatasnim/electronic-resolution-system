class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|

      t.string :title
      
      t.references :conference
      t.integer :committee_id
      t.integer :country_id
      t.integer :status_id, :default => 1
      t.integer :user_id

      t.integer :num_votes_for
      t.integer :num_votes_against
      t.integer :num_abstentions

      t.string :document_file_name
      t.string :document_content_type
      t.integer :document_file_size
      t.datetime :document_updated_at

      t.timestamps
    end
    add_index :resolutions, :conference_id
  end
end