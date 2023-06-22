class TaxasController < ApplicationController
    layout 'cruds'
    before_action :set_taxa, only: [:show, :edit, :update, :destroy]

    # GET /taxas
    def index
        unless request.format.in?(['html', 'js'])
            @taxas = Taxa.all
        end
        respond_to do |format|
            format.html
            format.json
            format.js
        end
    end

    # GET /taxas/1
    def show;end

    # GET /taxas/new
    def new
        @taxa = Taxa.new(taxa_params)
    end

    # GET /taxas/1/edit
    def edit;end

    # POST /taxas
    def create
        @taxa = Taxa.new(taxa_params)
        notice = 'Taxa cadastrado(a) com sucesso.'
        respond_to do |format|
            if @taxa.save
                remote = params.try(:[], :remote)
                location = [@taxa]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? || remote == 'false' ? location : taxas_path, notice: notice}
                format.json { render :show, status: :created, location: @taxa }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @taxa.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /taxas/1
    def update
        notice = 'Taxa alterado(a) com sucesso.'
        respond_to do |format|
            if @taxa.update(taxa_params)
                remote = params.try(:[], :remote)
                location = [@taxa]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? || remote == 'false' ? location : taxas_path, notice: notice}
                format.json { render :show, status: :ok, location: location }
                format.js { flash[:notice] = notice}
            else
                format.html { render :edit, status: :unprocessable_entity  }
                format.json { render json: @taxa.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /taxas/1
    def destroy
        @taxa.destroy
        notice = 'Taxa removido(a) com sucesso.'
        respond_to do |format|
            format.html { redirect_to params[:controller].split("/").map(&:to_sym), notice: notice }
            format.json { head :no_content }
            format.js { render partial: 'shared/errors', locals: {errors: @taxa.errors} }
        end
    end

    def datatable
        respond_to do |format|
            format.json { render json: TaxasDatatable.new(view_context) }
        end
    end

    def search
        respond_to do |format|
            format.json { render json: Taxa.search(params[:search])  }
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_taxa
            @taxa = Taxa.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def taxa_params
            if params[:taxa]
                    params.require(:taxa).permit(:valor_kwh, :bandeira, :deleted_at)
            end
        end


end
    