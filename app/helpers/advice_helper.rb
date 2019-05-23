module AdviceHelper
  def advices_period
    "Du #{l(params[:from], format: '%d %B')} au #{l(params[:to], format: '%d %B')}"
  end
end
