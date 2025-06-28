class CreateTasas < ActiveRecord::Migration[7.1]
  def change
    create_table :tasas do |t|
      t.string :nombre
      t.decimal :porcentaje

      t.timestamps
    end
  end
end
