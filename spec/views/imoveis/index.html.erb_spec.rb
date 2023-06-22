require 'rails_helper'

RSpec.describe "imoveis/index", type: :view do
  before(:each) do
    assign(:imoveis, [
      Imovel.create!(
        nome: "Nome",
        endereco: "Endereco",
        cep: "Cep"
      ),
      Imovel.create!(
        nome: "Nome",
        endereco: "Endereco",
        cep: "Cep"
      )
    ])
  end

  it "renders a list of imoveis" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Nome".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Endereco".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Cep".to_s), count: 2
  end
end
