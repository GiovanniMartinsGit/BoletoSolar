class CreateHistoricoConsumo < ActiveRecord::Migration[7.0]
  def change
    create_table :historico_consumos, id: :uuid do |t|
      t.references :imovel, null: false, foreign_key: true, type: :uuid
      t.integer :consumo
      t.integer :leitura
      t.datetime :data_consumo
      t.float :valor_consumo

      t.timestamps
    end
  end
end
