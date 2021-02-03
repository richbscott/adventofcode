require './inputs'

input = Inputs::DAY21


all_allergens = {}
all_ingredients = {}

input.split("\n").each_with_index do |row, i|

    ingredients, allergens = row.split(' (contains ') 

    ingredients = ingredients.split(' ')
    allergens = allergens[0..-2].split(', ')

    ingredients.each do |ingredient|
      if all_ingredients[ingredient]
        all_ingredients[ingredient] += 1
      else 
        all_ingredients[ingredient] = 1
      end
    end

    allergens.each do |allergen|
        if all_allergens[allergen]
          all_allergens[allergen] = all_allergens[allergen] & ingredients
        else 
          all_allergens[allergen] = ingredients
        end
    end

end


identifiedingredients = {}


all_allergens.each do |allergen, ingredients|
  if ingredients.size == 1
    identifiedingredients[ingredients[0]] = allergen
 end
end

#puts identifiedingredients

found = true
while found == true
    found = false
    all_allergens.each do |allergen, ingredients|
        #puts "A" + identifiedingredients.keys.to_s
        #puts "B" + all_allergens[allergen].to_a.to_s
        #puts "C" + (all_allergens[allergen].to_a - identifiedingredients.keys.to_a).to_s
        all_allergens[allergen] = (all_allergens[allergen].to_a - identifiedingredients.keys)
        if all_allergens[allergen].size == 1
          identifiedingredients[all_allergens[allergen][0]] = allergen
          found = true
        end
    end
end

#puts identifiedingredients

#puts all_ingredients.to_s
nonallergen = (all_ingredients.keys - identifiedingredients.keys)

#puts nonallergen.to_s

total = 0

nonallergen.each do |ingredient|
    total += all_ingredients[ingredient]
end

# part1
puts total

# part2
dangerous = identifiedingredients.sort_by {|k, v| v}
puts dangerous.to_h.keys.join(',')