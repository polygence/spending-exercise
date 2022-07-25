class CreateSpendings < ActiveRecord::Migration[7.0]
  def change
    create_table :spendings do |t|
      t.string     :description, null: false
      t.decimal    :amount,      null: false, precision: 10, scale: 2
      t.references :currency,    foreign_key: true

      t.timestamps
    end
  end
end
