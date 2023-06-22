require 'rails_helper'

RSpec.describe "moradores/index", type: :view do
  before(:each) do
    assign(:moradores, [
      Morador.create!(
        nome: "Nome",
        cpf: "Cpf"
      ),
      Morador.create!(
        nome: "Nome",
        cpf: "Cpf"
      )
    ])
  end

  it "renders a list of moradores" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Nome".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Cpf".to_s), count: 2
  end
end
