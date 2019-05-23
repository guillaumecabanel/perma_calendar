class CreateAdvices < ActiveRecord::Migration[5.2]
  def change
    create_table :advices do |t|
      t.text :content
      t.string :garden_category
      t.datetime :from_date
      t.datetime :to_date

      t.timestamps
    end

    add_index :advices, [:from_date, :garden_category]
  end
end
