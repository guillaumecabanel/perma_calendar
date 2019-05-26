class AddActionToAdvice < ActiveRecord::Migration[5.2]
  def change
    add_column :advices, :action, :string, default: 'other'
  end
end
