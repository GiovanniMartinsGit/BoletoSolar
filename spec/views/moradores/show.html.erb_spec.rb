require 'rails_helper'

RSpec.describe "moradores/show", type: :view do
  before(:each) do
    assign(:morador, Morador.create!(
      nome: "Nome",
      cpf: "Cpf"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nome/)
    expect(rendered).to match(/Cpf/)
  end
end
