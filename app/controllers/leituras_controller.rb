class LeiturasController < ApplicationController
    layout 'cruds'
    before_action :set_leitura, only: [:show, :edit, :update, :destroy]

    # GET /leituras
    def index
        unless request.format.in?(['html', 'js'])
            @leituras = Leitura.all
        end
        respond_to do |format|
            format.html
            format.json
            format.js
        end
    end

    # GET /leituras/1
    def show;end

    # GET /leituras/new
    def new
        @leitura = Leitura.new(leitura_params)
    end

    # GET /leituras/1/edit
    def edit;end

    # POST /leituras
    def create
        @leitura = Leitura.new(leitura_params)
        notice = 'Leitura cadastrado(a) com sucesso.'
        respond_to do |format|
            if @leitura.save
                remote = params.try(:[], :remote)
                location = [@leitura]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? || remote == 'false' ? location : leituras_path, notice: notice}
                format.json { render :show, status: :created, location: @leitura }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @leitura.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /leituras/1
    def update
        notice = 'Leitura alterado(a) com sucesso.'
        respond_to do |format|
            if @leitura.update(leitura_params)
                remote = params.try(:[], :remote)
                location = [@leitura]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? || remote == 'false' ? location : leituras_path, notice: notice}
                format.json { render :show, status: :ok, location: location }
                format.js { flash[:notice] = notice}
            else
                format.html { render :edit, status: :unprocessable_entity  }
                format.json { render json: @leitura.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /leituras/1
    def destroy
        @leitura.destroy
        notice = 'Leitura removido(a) com sucesso.'
        respond_to do |format|
            format.html { redirect_to params[:controller].split("/").map(&:to_sym), notice: notice }
            format.json { head :no_content }
            format.js { render partial: 'shared/errors', locals: {errors: @leitura.errors} }
        end
    end

    def datatable
        respond_to do |format|
            format.json { render json: LeiturasDatatable.new(view_context) }
        end
    end

    def search
        respond_to do |format|
            format.json { render json: Leitura.search(params[:search])  }
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_leitura
            @leitura = Leitura.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def leitura_params
            if params[:leitura]
                    params.require(:leitura).permit(:valor_leitura, :data_leitura, :deleted_at)
            end
        end


end
    