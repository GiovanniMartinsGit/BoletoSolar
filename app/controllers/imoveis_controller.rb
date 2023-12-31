class ImoveisController < ApplicationController
    layout 'cruds'
    before_action :set_imovel, only: [:show, :edit, :update, :destroy]

    # GET /imoveis
    def index
        unless request.format.in?(['html', 'js'])
            @imoveis = Imovel.all
        end
        respond_to do |format|
            format.html
            format.json
            format.js
        end
    end

    # GET /imoveis/1
    def show;end

    # GET /imoveis/new
    def new
        @imovel = Imovel.new(imovel_params)
    end

    # GET /imoveis/1/edit
    def edit;end

    # POST /imoveis
    def create
        @imovel = Imovel.new(imovel_params)
        notice = 'Imovel cadastrado(a) com sucesso.'
        respond_to do |format|
            if @imovel.save
                remote = params.try(:[], :remote)
                location = [@imovel]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? || remote == 'false' ? location : imoveis_path, notice: notice}
                format.json { render :show, status: :created, location: @imovel }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @imovel.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /imoveis/1
    def update
        notice = 'Imovel alterado(a) com sucesso.'
        respond_to do |format|
            if @imovel.update(imovel_params)
                remote = params.try(:[], :remote)
                location = [@imovel]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? || remote == 'false' ? location : imoveis_path, notice: notice}
                format.json { render :show, status: :ok, location: location }
                format.js { flash[:notice] = notice}
            else
                format.html { render :edit, status: :unprocessable_entity  }
                format.json { render json: @imovel.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /imoveis/1
    def destroy
        @imovel.destroy
        notice = 'Imovel removido(a) com sucesso.'
        respond_to do |format|
            format.html { redirect_to params[:controller].split("/").map(&:to_sym), notice: notice }
            format.json { head :no_content }
            format.js { render partial: 'shared/errors', locals: {errors: @imovel.errors} }
        end
    end

    def gerar_fatura
      @imovel = Imovel.find(params[:id])
      @leitura_atual = @imovel.leitura_mes
      @consumo = @imovel.consumo_energia
      @total = @consumo * Taxa.last.valor_kwh
      
      # Verificar se já existe um registro de consumo para o mês atual
      historico_mes_atual = HistoricoConsumo.find_by(imovel_id: @imovel.id, data_consumo: Date.today.beginning_of_month..Date.today.end_of_month)

       # Criar um novo registro apenas se não existir um para o mês atual
      if historico_mes_atual.nil?
        HistoricoConsumo.create(
          imovel_id: @imovel.id,
          consumo: @consumo,
          leitura: @leitura_atual.valor_leitura,
          data_consumo: @leitura_atual.data_leitura,
          valor_consumo: @total
        ) 
      end
    
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "Fatura - #{@imovel.nome}",
                 template: "imoveis/gerar_fatura",
                 layout: "layouts/pdf",
                 formats: [:html]
        end
      end
    end

    def datatable
        respond_to do |format|
            format.json { render json: ImoveisDatatable.new(view_context) }
        end
    end

    def search
        respond_to do |format|
            format.json { render json: Imovel.search(params[:search])  }
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_imovel
            @imovel = Imovel.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def imovel_params
            if params[:imovel]
                    params.require(:imovel).permit(:nome, :endereco, :cep, :morador_id, :deleted_at)
            end
        end


end
    