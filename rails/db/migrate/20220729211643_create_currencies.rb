class CreateCurrencies < ActiveRecord::Migration[7.0]
  def change
    create_table :currencies do |t|
      t.string  :name,  null: false, index: { unique: true }
      t.integer :scale, null: false, default: 0
      t.timestamps
    end
  end
end
