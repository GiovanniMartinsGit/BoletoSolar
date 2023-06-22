require 'rails_helper'

RSpec.describe "imoveis/show", type: :view do
  before(:each) do
    assign(:imovel, Imovel.create!(
      nome: "Nome",
      endereco: "Endereco",
      cep: "Cep"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nome/)
    expect(rendered).to match(/Endereco/)
    expect(rendered).to match(/Cep/)
  end
end
