class TaxasDatatable
    delegate :params, :h, :t, :link_to, :button_to, :content_tag, 
        :taxa_path, 
        :edit_taxa_path, to: :@view
  
    
    def initialize(view)
        @view = view
        @remote = params[:remote] == 'true'
    end

    def as_json(_options = {})
        {
            draw: params[:draw].to_i,
            recordsTotal: total,
            recordsFiltered: taxas.total_count,
            data: data
        }
    end

    private 
        def data
            taxas.each_with_index.map do |taxa, index|
                {
                    'index' => (index + 1) + ((page - 1) * per_page),
                    
                    'opcoes' => column_opcoes(taxa)
                }
            end
        end


        

        
        def column_opcoes(taxa)
            opcoes = ""

            opcoes << (link_to(taxa_path(taxa),
                    { remote: @remote, class: 'btn btn-icon btn-primary me-2 mb-2', title: 'Visualizar',
                    data: { toggle: 'tooltip', placement: 'top' } }) do
                    content_tag(:i, '', class: 'las la-search')
            end).to_s

            opcoes << (link_to(edit_taxa_path(taxa),
                        { remote: @remote, class: 'btn btn-icon btn-warning me-2 mb-2', title: 'Editar',
                        data: { toggle: 'tooltip', placement: 'top' } }) do
                content_tag(:i, '', class: 'las la-edit')
                end).to_s

            opcoes << (button_to taxa_path(taxa),
                        method: :delete,
                        data: { confirm: t('helpers.links.confirm_destroy', model: taxa.model_name.human), toggle: 'tooltip', placement: 'top' },
                        remote: @remote,
                        class: 'btn btn-icon btn-danger me-2 mb-2', title: 'Remover' do
                    content_tag(:i, '', class: 'las la-trash')
                end).to_s

            opcoes.html_safe
        end

        def taxas
            @taxas ||= fetch
        end

        def query
            'Taxa'
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
            columns = []
            columns[params[:order]['0'][:column].to_i]
        end

        def sort_direction
            params[:order]['0'][:dir] == 'desc' ? 'desc' : 'asc'
        end


end