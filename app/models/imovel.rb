class Imovel < ApplicationRecord

  # extends ...................................................................
  
  # includes ..................................................................
  audited
  acts_as_paranoid

  include Searchrable

  has_many :historico_consumos
  has_many :leituras, dependent: :destroy
  belongs_to :morador

  # security (i.e. attr_accessible) ...........................................
  
  def consumo_energia
    leitura_atual = leitura_mes
    leitura_mes_passado = leitura_anterior

    if leitura_mes_passado
      consumo = leitura_atual.valor_leitura - leitura_mes_passado.valor_leitura
    else
      consumo = 0
    end

    consumo
  end

  def leitura_mes
    leituras.last
  end

  def leitura_anterior
    leitura_atual = leitura_mes
    leituras.where('data_leitura < ?', leitura_atual.data_leitura)
            .order(data_leitura: :desc)
            .first
  end

      
  # relationships .............................................................
  
  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................
  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
end