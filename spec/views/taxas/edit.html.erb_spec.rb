require 'rails_helper'

RSpec.describe "taxas/edit", type: :view do
  let(:taxa) {
    Taxa.create!(
      valor_kwh: 1.5,
      bandeira: 1.5
    )
  }

  before(:each) do
    assign(:taxa, taxa)
  end

  it "renders the edit taxa form" do
    render

    assert_select "form[action=?][method=?]", taxa_path(taxa), "post" do

      assert_select "input[name=?]", "taxa[valor_kwh]"

      assert_select "input[name=?]", "taxa[bandeira]"
    end
  end
end
