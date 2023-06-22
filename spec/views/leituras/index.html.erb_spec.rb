require 'rails_helper'

RSpec.describe "leituras/index", type: :view do
  before(:each) do
    assign(:leituras, [
      Leitura.create!(
        valor_leitura: 2
      ),
      Leitura.create!(
        valor_leitura: 2
      )
    ])
  end

  it "renders a list of leituras" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end
end
