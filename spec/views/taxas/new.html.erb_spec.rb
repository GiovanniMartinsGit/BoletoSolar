require 'rails_helper'

RSpec.describe "taxas/new", type: :view do
  before(:each) do
    assign(:taxa, Taxa.new(
      valor_kwh: 1.5,
      bandeira: 1.5
    ))
  end

  it "renders new taxa form" do
    render

    assert_select "form[action=?][method=?]", taxas_path, "post" do

      assert_select "input[name=?]", "taxa[valor_kwh]"

      assert_select "input[name=?]", "taxa[bandeira]"
    end
  end
end
