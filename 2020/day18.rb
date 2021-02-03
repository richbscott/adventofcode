require './inputs'

input = Inputs::DAY18

#1 + (2 * 3) + (4 * (5 + 6))

def processEquation(row)

  while true
    space_count = 0
    start_position = 0
    for i in 0..row.length-1
      #puts i
      if row[i] == ' '  || (i == row.length-1)
        space_count += 1
        if space_count == 3 || (i == row.length-1)
          if i == row.length-1
            endpoint = row.length-1
          else
            endpoint = i-1
          end
          part = row[start_position..endpoint]      
          result = eval(part)
          row[start_position..i] = result.to_s.strip() + ' '
          break
        end
      end
    end

    if row.strip !~ /\D/
      break
    end

  end

  return row

end

def processEquation2(row, operator)

  while row.include?(operator)
    space_count = 0
    start_position = 0
    space_position = 0
    for i in 0..row.length-1
      #puts i
      if row[i] == ' '  || (i == row.length-1)
        space_count += 1
        if space_count == 3 || (i == row.length-1)
          if i == row.length-1
            endpoint = row.length-1
          else
            endpoint = i-1
          end
          part = row[start_position..endpoint]    
          if part.include?(operator)
            #puts "PART: " + part
            result = eval(part)
            row[start_position..i] = result.to_s.strip() + ' '
            break
          else
            start_position = space_position+1
            #puts row + ' : '  +  i.to_s
            space_count = 1
          end
        end
        space_position = i
      end
    end

    if row.strip !~ /\D/
      break
    end

  end

  return row

end


def findDeepestBrackets(line)
  current_max = 0
  max = 0
  position = -1
  for i in 0..line.length-1
    if (line[i] == '(')
      current_max += 1

      if current_max > max 
        max = current_max
        position = i
      end
    elsif
      line[i] == ')'
      if current_max > 0 
        current_max -= 1
      else
        return -1; 
      end
    end

  end

  if current_max != 0 
    return -1; 
  end

  return position

end

total = 0

input.split("\n").each_with_index do |row, i|
  linesum = 0

  row2 = row.clone

  #puts row
  # Process brackets
  while true
    deepestbracket = findDeepestBrackets(row)
    if deepestbracket > -1
      endbracket = row.index(')', deepestbracket)
      bracketsection = row[deepestbracket+1..endbracket-1]
      result = processEquation(bracketsection)
      row[deepestbracket..endbracket] = result.strip.to_s
    else
      break
    end
  end

  row = processEquation(row)

  #puts row
  total += row.to_i


end

#Part 1
puts total

#Part 2
total = 0

input.split("\n").each_with_index do |row, i|
  linesum = 0

  row2 = row.clone

  #puts row
  # Process brackets
  while true
    deepestbracket = findDeepestBrackets(row)
    if deepestbracket > -1
      endbracket = row.index(')', deepestbracket)
      bracketsection = row[deepestbracket+1..endbracket-1]
      #puts "Bracket Section: " + bracketsection
      result = processEquation2(bracketsection, '+')
      #puts "Processed + : " + result
      result = processEquation2(result, '*')
      #puts "Processed * : " + result
      row[deepestbracket..endbracket] = result.strip.to_s
      
    else
      break
    end
  end


  #puts "Row " + row
  #row = '6 * 3 + 5 * 178 + 7 + 9'
  #puts row
  row = processEquation2(row, '+')
  #puts "Row after + " + row
  row = processEquation2(row, '*')
  #puts row
  total += row.to_i


end

puts total.to_s
