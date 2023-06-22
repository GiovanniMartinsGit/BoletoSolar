require 'rails_helper'

RSpec.describe "leituras/show", type: :view do
  before(:each) do
    assign(:leitura, Leitura.create!(
      valor_leitura: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
  end
end
