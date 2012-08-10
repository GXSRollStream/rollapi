class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.integer :target_id
      t.string :target_type
      t.string :target_kind
      t.text :response
      t.text :body
      t.string :url
      t.string :user
      t.string :password
      t.string :api_key

      t.timestamps
    end
  end
end
