require './inputs'

input = Inputs::DAY4

required_fields = ['byr',
                   'iyr',
                   'eyr',
                   'hgt',
                   'hcl',
                   'ecl',
                   'pid']

#cid

def checkIsValid(passport)
  return false if !passport['byr'].to_i.between?(1920, 2002)
  return false if !passport['iyr'].to_i.between?(2010, 2020)
  return false if !passport['eyr'].to_i.between?(2020, 2030)

  hgtunits = passport['hgt'].split(//).last(2).join
  
  if hgtunits == 'cm'
    return false if !passport['hgt'].to_i.between?(150, 193)
  elsif hgtunits == 'in'
    return false if !passport['hgt'].to_i.between?(59, 76)
  else
    return false
  end
  
  return false if !(passport['hcl'] =~ /^#[\h]{6}$/i)
  return false if !['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].include?(passport['ecl'])
  return false if !(passport['pid'] =~ /^[\d]{9}$/i)

  return true
end

p1validpassports = 0
p2validpassports = 0

input.split(/\n{2,}/).each do |passportstring|
  passportstring.split(/[\s,']/)
  passport = passportstring.split(/[\s,']/).each_with_object({}) do |str, h| 
    k,v = str.split(":")
    h[k] = v
  end

  # Check if all required fields are present
  if (required_fields - passport.keys).empty?
    p1validpassports += 1   
    p2validpassports += 1 if checkIsValid(passport)
  end
end

#Part 1
puts p1validpassports

#Part 2 
puts p2validpassports