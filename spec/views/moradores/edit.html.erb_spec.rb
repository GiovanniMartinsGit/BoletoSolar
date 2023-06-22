require 'rails_helper'

RSpec.describe "moradores/edit", type: :view do
  let(:morador) {
    Morador.create!(
      nome: "MyString",
      cpf: "MyString"
    )
  }

  before(:each) do
    assign(:morador, morador)
  end

  it "renders the edit morador form" do
    render

    assert_select "form[action=?][method=?]", morador_path(morador), "post" do

      assert_select "input[name=?]", "morador[nome]"

      assert_select "input[name=?]", "morador[cpf]"
    end
  end
end
