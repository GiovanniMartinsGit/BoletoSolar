class AddReferenceToLeituras < ActiveRecord::Migration[7.0]
  def change
    add_reference :leituras, :imovel, null: false, foreign_key: true, type: :uuid
  end
end
