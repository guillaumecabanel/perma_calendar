class AdvicesController < ApplicationController
  def index
    @date = params[:date].present? ? DateTime.parse(params[:date]) : DateTime.current

    @advices = Advice.where(where_dates, @date.day, @date.month, @date.day, @date.month)

    if %w[vegetable_garden orchard ornamental_garden].include? params[:garden]
      @advices = @advices.where(garden_category: params[:garden])
    else
      @advices = @advices.where(garden_category: 'vegetable_garden')
    end

    params[:from] = @advices.first.from_date
    params[:to] = @advices.first.to_date
    
    @advices = @advices.order(:from_date)
  end

  private

  def where_dates
    <<-SQL
      DATE_PART('day', from_date) <= ?
      AND DATE_PART('month', from_date) <= ?
      AND DATE_PART('day', to_date) >= ?
      AND DATE_PART('month', to_date) >= ?
    SQL
  end
end
