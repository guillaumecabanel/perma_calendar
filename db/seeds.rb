require 'csv'

def set_garden_category(text)
  case text.strip
  when 'Au potager'           then 'vegetable_garden'
  when 'Au verger'            then 'orchard'
  when 'Au jardin d’ornement' then 'ornamental_garden'
  end
end

csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
file_path = File.join(Rails.root, 'db', 'csv', 'enriched_advices.csv')

puts 'Importing advices from CSV'

CSV.foreach(file_path, csv_options) do |row|
  Advice.create!(
    from_date:       DateTime.parse(row['from_date']),
    to_date:         DateTime.parse(row['to_date']).end_of_day,
    content:         row['content'],
    garden_category: set_garden_category(row['garden_category'])
  )
  print '.'
end

puts "\nDone."
