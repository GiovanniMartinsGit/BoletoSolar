require 'rails_helper'

RSpec.describe "moradores/new", type: :view do
  before(:each) do
    assign(:morador, Morador.new(
      nome: "MyString",
      cpf: "MyString"
    ))
  end

  it "renders new morador form" do
    render

    assert_select "form[action=?][method=?]", moradores_path, "post" do

      assert_select "input[name=?]", "morador[nome]"

      assert_select "input[name=?]", "morador[cpf]"
    end
  end
end
