class CreateGuests < ActiveRecord::Migration[6.1]
  def change
    create_table :guests do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :first_name
      t.string :last_name
      t.text :phone_numbers, default: [], array:true

      t.timestamps({default: -> { "CURRENT_TIMESTAMP" }})
    end
  end
end
