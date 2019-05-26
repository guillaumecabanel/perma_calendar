require 'csv'

ACTIONS = [
  { pattern: "Semez",      title: "seed" },
  { pattern: "Plantez",    title: "plant" },
  { pattern: "Binez",      title: "maintenance" },
  { pattern: "Buttez",     title: "maintenance" },
  { pattern: "Couvrez",    title: "maintenance" },
  { pattern: "Débuttez ",  title: "maintenance" },
  { pattern: "Désherber",  title: "maintenance" },
  { pattern: "désherber",  title: "maintenance" },
  { pattern: "Installez",  title: "maintenance" },
  { pattern: "Nettoyez",   title: "maintenance" },
  { pattern: "Paillez",    title: "maintenance" },
  { pattern: "Protéger",   title: "maintenance" },
  { pattern: "Protégez",   title: "maintenance" },
  { pattern: "Travaillez", title: "maintenance" },
  { pattern: "Taillez",    title: "trim" },
  { pattern: "Arrosez",    title: "watering" },
  { pattern: "Récoltez",   title: "harvest" },
  { pattern: "compost",    title: "compost" },
]

def set_garden_category(text)
  case text.strip
  when 'Au potager'           then 'vegetable_garden'
  when 'Au verger'            then 'orchard'
  when 'Au jardin d’ornement' then 'ornamental_garden'
  end
end

def action_for(content)
  ACTIONS.each do |action|
    if content.match(/#{action[:pattern]}/)
       return action[:title]
    end
  end

  return 'other'
end

print 'Deleting data...'
Advice.destroy_all
puts 'OK'

csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
file_path = File.join(Rails.root, 'db', 'csv', 'enriched_advices.csv')

puts 'Importing advices from CSV'

CSV.foreach(file_path, csv_options) do |row|
  advice = Advice.create!(
    from_date:       DateTime.parse(row['from_date']),
    to_date:         DateTime.parse(row['to_date']).end_of_day,
    content:         row['content'],
    garden_category: set_garden_category(row['garden_category']),
  )

  advice.action = action_for(advice.content)
  advice.save

  print '.'
end

advice_count = Advice.all.count

puts "\nDone.\n"
puts "-" * 200
puts "Stats:\n"
puts "Advices: #{advice_count}"

plant_count = Advice.where(action: 'plant').count
plant_ratio = (plant_count.fdiv(advice_count) * 100).round(1)
puts "Plant:       #{plant_count} [#{plant_ratio}%]"

seed_count = Advice.where(action: 'seed').count
seed_ratio = (seed_count.fdiv(advice_count) * 100).round(1)
puts "Seed:        #{seed_count} [#{seed_ratio}%]"

harvest_count = Advice.where(action: 'harvest').count
harvest_ratio = (harvest_count.fdiv(advice_count) * 100).round(1)
puts "Harvest:     #{harvest_count} [#{harvest_ratio}%]"

maintenance_count = Advice.where(action: 'maintenance').count
maintenance_ratio = (maintenance_count.fdiv(advice_count) * 100).round(1)
puts "Maintenance: #{maintenance_count} [#{maintenance_ratio}%]"

compost_count = Advice.where(action: 'compost').count
compost_ratio = (compost_count.fdiv(advice_count) * 100).round(1)
puts "Compost:     #{compost_count} [#{compost_ratio}%]"

watering_count = Advice.where(action: 'watering').count
watering_ratio = (watering_count.fdiv(advice_count) * 100).round(1)
puts "Watering:    #{watering_count} [#{watering_ratio}%]"

trim_count = Advice.where(action: 'trim').count
trim_ratio = (trim_count.fdiv(advice_count) * 100).round(1)
puts "Trim:        #{trim_count} [#{trim_ratio}%]"

other_count = Advice.where(action: 'other').count
other_ratio = (other_count.fdiv(advice_count) * 100).round(1)
puts "Other:       #{other_count} [#{other_ratio}%]"
