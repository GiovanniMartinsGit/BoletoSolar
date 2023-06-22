require 'rails_helper'

RSpec.describe "leituras/new", type: :view do
  before(:each) do
    assign(:leitura, Leitura.new(
      valor_leitura: 1
    ))
  end

  it "renders new leitura form" do
    render

    assert_select "form[action=?][method=?]", leituras_path, "post" do

      assert_select "input[name=?]", "leitura[valor_leitura]"
    end
  end
end
