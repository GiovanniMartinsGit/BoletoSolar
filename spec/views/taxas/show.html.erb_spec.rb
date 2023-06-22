require 'rails_helper'

RSpec.describe "taxas/show", type: :view do
  before(:each) do
    assign(:taxa, Taxa.create!(
      valor_kwh: 2.5,
      bandeira: 3.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/3.5/)
  end
end
