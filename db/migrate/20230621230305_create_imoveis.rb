class CreateImoveis < ActiveRecord::Migration[7.0]
  def change
    create_table :imoveis, id: :uuid do |t|
      t.string :nome
      t.string :endereco
      t.string :cep
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :imoveis, :deleted_at
  end
end
