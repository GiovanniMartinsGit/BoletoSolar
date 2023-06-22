class MoradoresDatatable
    delegate :params, :h, :t, :link_to, :button_to, :content_tag, 
        :morador_path, 
        :edit_morador_path, to: :@view
  
    
    def initialize(view)
        @view = view
        @remote = params[:remote] == 'true'
    end

    def as_json(_options = {})
        {
            draw: params[:draw].to_i,
            recordsTotal: total,
            recordsFiltered: moradores.total_count,
            data: data
        }
    end

    private 
        def data
            moradores.each_with_index.map do |morador, index|
                {
                    'index' => (index + 1) + ((page - 1) * per_page),
                                            
                                            
                            'nome' => column_nome(morador),
                        
                                            
                            'cpf' => column_cpf(morador),
                        
                                            
                                            
                            'created_at' => column_created_at(morador),
                        
                                            
                            'updated_at' => column_updated_at(morador),
                        
                    
                    'opcoes' => column_opcoes(morador)
                }
            end
        end


                    
                    
                def column_nome(morador)
                    
                        morador.try(:nome)
                    
                end
            
                    
                def column_cpf(morador)
                    
                        morador.try(:cpf)
                    
                end
            
                    
                    
                def column_created_at(morador)
                    
                        morador.try(:created_at).try(:to_fs)
                    
                end
            
                    
                def column_updated_at(morador)
                    
                        morador.try(:updated_at).try(:to_fs)
                    
                end
            
        

        
        def column_opcoes(morador)
            opcoes = ""

            opcoes << (link_to(morador_path(morador),
                    { remote: @remote, class: 'btn btn-icon btn-primary me-2 mb-2', title: 'Visualizar',
                    data: { toggle: 'tooltip', placement: 'top' } }) do
                    content_tag(:i, '', class: 'las la-search')
            end).to_s

            opcoes << (link_to(edit_morador_path(morador),
                        { remote: @remote, class: 'btn btn-icon btn-warning me-2 mb-2', title: 'Editar',
                        data: { toggle: 'tooltip', placement: 'top' } }) do
                content_tag(:i, '', class: 'las la-edit')
                end).to_s

            opcoes << (button_to morador_path(morador),
                        method: :delete,
                        data: { confirm: t('helpers.links.confirm_destroy', model: morador.model_name.human), toggle: 'tooltip', placement: 'top' },
                        remote: @remote,
                        class: 'btn btn-icon btn-danger me-2 mb-2', title: 'Remover' do
                    content_tag(:i, '', class: 'las la-trash')
                end).to_s

            opcoes.html_safe
        end

        def moradores
            @moradores ||= fetch
        end

        def query
            'Morador'
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
            columns = ["id", "nome", "cpf", "created_at", "updated_at"]
            columns[params[:order]['0'][:column].to_i]
        end

        def sort_direction
            params[:order]['0'][:dir] == 'desc' ? 'desc' : 'asc'
        end


end