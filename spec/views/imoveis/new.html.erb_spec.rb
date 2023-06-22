require 'rails_helper'

RSpec.describe "imoveis/new", type: :view do
  before(:each) do
    assign(:imovel, Imovel.new(
      nome: "MyString",
      endereco: "MyString",
      cep: "MyString"
    ))
  end

  it "renders new imovel form" do
    render

    assert_select "form[action=?][method=?]", imoveis_path, "post" do

      assert_select "input[name=?]", "imovel[nome]"

      assert_select "input[name=?]", "imovel[endereco]"

      assert_select "input[name=?]", "imovel[cep]"
    end
  end
end
