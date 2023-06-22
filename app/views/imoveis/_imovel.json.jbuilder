json.extract! imovel, :id, :nome, :endereco, :cep, :deleted_at, :created_at, :updated_at
json.url imovel_url(imovel, format: :json)
