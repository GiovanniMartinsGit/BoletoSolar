require 'rails_helper'

RSpec.describe "imoveis/edit", type: :view do
  let(:imovel) {
    Imovel.create!(
      nome: "MyString",
      endereco: "MyString",
      cep: "MyString"
    )
  }

  before(:each) do
    assign(:imovel, imovel)
  end

  it "renders the edit imovel form" do
    render

    assert_select "form[action=?][method=?]", imovel_path(imovel), "post" do

      assert_select "input[name=?]", "imovel[nome]"

      assert_select "input[name=?]", "imovel[endereco]"

      assert_select "input[name=?]", "imovel[cep]"
    end
  end
end
