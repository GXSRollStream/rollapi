class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :request_id
      t.string :request_method
      t.string :request_owner
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
