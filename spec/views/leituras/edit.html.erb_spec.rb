require 'rails_helper'

RSpec.describe "leituras/edit", type: :view do
  let(:leitura) {
    Leitura.create!(
      valor_leitura: 1
    )
  }

  before(:each) do
    assign(:leitura, leitura)
  end

  it "renders the edit leitura form" do
    render

    assert_select "form[action=?][method=?]", leitura_path(leitura), "post" do

      assert_select "input[name=?]", "leitura[valor_leitura]"
    end
  end
end
