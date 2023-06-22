class CreateMoradores < ActiveRecord::Migration[7.0]
  def change
    create_table :moradores, id: :uuid do |t|
      t.string :nome
      t.string :cpf
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :moradores, :deleted_at
  end
end
