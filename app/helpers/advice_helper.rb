module AdviceHelper
  def advices_period
    "Du #{l(params[:from], format: '%d %B')} au #{l(params[:to], format: '%d %B')}"
  end

  def advice_action_icon(advice)
    action_icons = {
      seeding:     'seed',
      maintenance: 'gloves',
      watering:    'irrigation',
      compost:     'compost',
      harvest:     'scythe',
      other:       'cabbage'
    }

    image_tag "action-icons/#{action_icons[advice.action.to_sym]}-48.png"
  end
end
