class CreateHorses < ActiveRecord::Migration[5.2]
  def change
    create_table :horses do |t|
      t.string :name
      t.string :sex
      t.string :color
      t.string :breed
      t.integer :user_id
      t.timestamps
    end
  end
end
