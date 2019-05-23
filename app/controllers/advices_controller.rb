class AdvicesController < ApplicationController
  def index
    @advices = Advice.where("from_date <= ? AND to_date >= ?", DateTime.current.beginning_of_day, DateTime.current.end_of_day)

    if %w[vegetable_garden orchard ornamental_garden].include? params[:garden]
      @advices = @advices.where(garden_category: params[:garden])
    else
      @advices = @advices.where(garden_category: 'vegetable_garden')
    end

    params[:from] = @advices.first.from_date
    params[:to] = @advices.first.to_date
    
    @advices = @advices.order(:from_date)
  end
end
