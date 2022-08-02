class CreateUserInternalPositions < ActiveRecord::Migration[6.0]
  def change
    create_table :user_internal_positions do |t|
      t.integer :user_id, null:false
      t.references :internal_position, null: false, foreign_key: true

      t.timestamps
    end
  end
end
