class CreateUserHasInterests < ActiveRecord::Migration
  def change
    create_table :user_has_interests do |t|
      t.integer :user_id
      t.integer :interest_id

      t.timestamps null: false
    end
  end
end
