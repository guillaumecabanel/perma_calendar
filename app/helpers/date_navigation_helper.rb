module DateNavigationHelper
  def link_to_today_advice
    if DateTime.current < params[:from] || DateTime.current > params[:to]
      link_to "Aujourd'hui", advices_path({ garden: params[:garden] }.merge(date: (DateTime.current).strftime( '%d-%m-%Y')))
    end
  end
end
