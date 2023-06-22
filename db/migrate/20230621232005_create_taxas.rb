class CreateTaxas < ActiveRecord::Migration[7.0]
  def change
    create_table :taxas, id: :uuid do |t|
      t.float :valor_kwh
      t.float :bandeira
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :taxas, :deleted_at
  end
end
