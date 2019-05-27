module DateNavigationHelper
  def previous_date_navigation_link
    if DateTime.current < params[:from]
      link_to "Aujourd'hui", advices_path({ garden: params[:garden] }.merge(date: (DateTime.current).strftime( '%d-%m-%Y'))), class: 'button date-nav-link prev'
    elsif DateTime.current < params[:from] + 5.days
      link_to 'Quinzaine précédente', advices_path({ garden: params[:garden] }.merge(date: (params[:from] - 15.days).strftime( '%d-%m-%Y'))), class: 'button date-nav-link prev'
    else
      tag.div class: 'empty-nav-link'
    end
  end

  def next_date_navigation_link
    if DateTime.current > params[:to]
      link_to "Aujourd'hui", advices_path({ garden: params[:garden] }.merge(date: (DateTime.current).strftime( '%d-%m-%Y'))), class: 'button date-nav-link next'
    elsif DateTime.current > params[:to] - 5.days
      link_to 'Quinzaine suivante', advices_path({ garden: params[:garden] }.merge(date: (params[:to] + 15.days).strftime( '%d-%m-%Y'))), class: 'button date-nav-link next'
    else
      tag.div class: 'empty-nav-link'
    end
  end
end
