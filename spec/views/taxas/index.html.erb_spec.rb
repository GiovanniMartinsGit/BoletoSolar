require 'rails_helper'

RSpec.describe "taxas/index", type: :view do
  before(:each) do
    assign(:taxas, [
      Taxa.create!(
        valor_kwh: 2.5,
        bandeira: 3.5
      ),
      Taxa.create!(
        valor_kwh: 2.5,
        bandeira: 3.5
      )
    ])
  end

  it "renders a list of taxas" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.5.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.5.to_s), count: 2
  end
end
