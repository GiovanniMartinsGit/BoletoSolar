class CreateLeituras < ActiveRecord::Migration[7.0]
  def change
    create_table :leituras, id: :uuid do |t|
      t.integer :valor_leitura
      t.datetime :data_leitura
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :leituras, :deleted_at
  end
end
