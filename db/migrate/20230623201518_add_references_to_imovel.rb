class AddReferencesToImovel < ActiveRecord::Migration[7.0]
  def change
    add_reference :imoveis, :morador, null: false, foreign_key: true, type: :uuid
  end
end
