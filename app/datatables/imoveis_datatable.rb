class ImoveisDatatable
    delegate :params, :h, :t, :link_to, :button_to, :content_tag, 
        :imovel_path, 
        :edit_imovel_path, to: :@view
  
    
    def initialize(view)
        @view = view
        @remote = params[:remote] == 'true'
    end

    def as_json(_options = {})
        {
            draw: params[:draw].to_i,
            recordsTotal: total,
            recordsFiltered: imoveis.total_count,
            data: data
        }
    end

    private 
        def data
            imoveis.each_with_index.map do |imovel, index|
                {
                    'index' => (index + 1) + ((page - 1) * per_page),
                                            
                                            
                                            
                            'created_at' => column_created_at(imovel),
                        
                                            
                            'updated_at' => column_updated_at(imovel),
                        
                    
                    'opcoes' => column_opcoes(imovel)
                }
            end
        end


                    
                    
                    
                def column_created_at(imovel)
                    
                        imovel.try(:created_at).try(:to_fs)
                    
                end
            
                    
                def column_updated_at(imovel)
                    
                        imovel.try(:updated_at).try(:to_fs)
                    
                end
            
        

        
        def column_opcoes(imovel)
            opcoes = ""

            opcoes << (link_to(imovel_path(imovel),
                    { remote: @remote, class: 'btn btn-icon btn-primary me-2 mb-2', title: 'Visualizar',
                    data: { toggle: 'tooltip', placement: 'top' } }) do
                    content_tag(:i, '', class: 'las la-search')
            end).to_s

            opcoes << (link_to(edit_imovel_path(imovel),
                        { remote: @remote, class: 'btn btn-icon btn-warning me-2 mb-2', title: 'Editar',
                        data: { toggle: 'tooltip', placement: 'top' } }) do
                content_tag(:i, '', class: 'las la-edit')
                end).to_s

            opcoes << (button_to imovel_path(imovel),
                        method: :delete,
                        data: { confirm: t('helpers.links.confirm_destroy', model: imovel.model_name.human), toggle: 'tooltip', placement: 'top' },
                        remote: @remote,
                        class: 'btn btn-icon btn-danger me-2 mb-2', title: 'Remover' do
                    content_tag(:i, '', class: 'las la-trash')
                end).to_s

            opcoes.html_safe
        end

        def imoveis
            @imoveis ||= fetch
        end

        def query
            'Imovel'
        end

        def fetch
            str_query = query
            params[:columns].each do |column|
                str_query << ".where(#{column[1][:data]}: '#{column[1][:search][:value]}')" if column[1][:search][:value].present?
            end
            str_query << '.search(params[:search][:value])' if params[:search][:value].present?
            str_query << %{.order("#{sort_column}" => "#{sort_direction}").page(page).per(per_page)}
            eval str_query
        end

        def total
            str_query = query
            str_query << '.count'
            eval str_query
        end

        def page
            params[:start].to_i / per_page + 1
        end
    
        def per_page
            params[:length].to_i.positive? ? params[:length].to_i : 10
        end
    
        def sort_column
            columns = ["id", "created_at", "updated_at"]
            columns[params[:order]['0'][:column].to_i]
        end

        def sort_direction
            params[:order]['0'][:dir] == 'desc' ? 'desc' : 'asc'
        end


end