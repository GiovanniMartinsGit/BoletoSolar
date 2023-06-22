class MoradoresController < ApplicationController
    layout 'cruds'
    before_action :set_morador, only: [:show, :edit, :update, :destroy]

    # GET /moradores
    def index
        unless request.format.in?(['html', 'js'])
            @moradores = Morador.all
        end
        respond_to do |format|
            format.html
            format.json
            format.js
        end
    end

    # GET /moradores/1
    def show;end

    # GET /moradores/new
    def new
        @morador = Morador.new(morador_params)
    end

    # GET /moradores/1/edit
    def edit;end

    # POST /moradores
    def create
        @morador = Morador.new(morador_params)
        notice = 'Morador cadastrado(a) com sucesso.'
        respond_to do |format|
            if @morador.save
                remote = params.try(:[], :remote)
                location = [@morador]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? || remote == 'false' ? location : moradores_path, notice: notice}
                format.json { render :show, status: :created, location: @morador }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @morador.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /moradores/1
    def update
        notice = 'Morador alterado(a) com sucesso.'
        respond_to do |format|
            if @morador.update(morador_params)
                remote = params.try(:[], :remote)
                location = [@morador]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? || remote == 'false' ? location : moradores_path, notice: notice}
                format.json { render :show, status: :ok, location: location }
                format.js { flash[:notice] = notice}
            else
                format.html { render :edit, status: :unprocessable_entity  }
                format.json { render json: @morador.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /moradores/1
    def destroy
        @morador.destroy
        notice = 'Morador removido(a) com sucesso.'
        respond_to do |format|
            format.html { redirect_to params[:controller].split("/").map(&:to_sym), notice: notice }
            format.json { head :no_content }
            format.js { render partial: 'shared/errors', locals: {errors: @morador.errors} }
        end
    end

    def datatable
        respond_to do |format|
            format.json { render json: MoradoresDatatable.new(view_context) }
        end
    end

    def search
        respond_to do |format|
            format.json { render json: Morador.search(params[:search])  }
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_morador
            @morador = Morador.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def morador_params
            if params[:morador]
                    params.require(:morador).permit(:nome, :cpf, :deleted_at)
            end
        end


end
    