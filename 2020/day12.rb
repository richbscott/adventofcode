require './inputs'

input = Inputs::DAY12

facingvalues = {0 => 'N', 90 => 'E', 180 => 'S', 270 => 'W' }
facingdir = 'E'
facingvalue = 90
easttotal = 0
northtotal = 0
waypointeast = 10
waypointnorth = 1

p2easttotal = 0
p2northtotal = 0

input.split("\n").each do |row|

  dir = row[0]
  distance = row[1..-1].to_i

  case dir[0,1]
  when "E"
    easttotal += distance
    waypointeast += distance
  when "W"
    easttotal -= distance
    waypointeast -= distance
  when "N"
    northtotal += distance
    waypointnorth += distance
  when "S"
    northtotal -= distance
    waypointnorth -= distance
  when "L"
    facingvalue = (360 + (facingvalue - distance)) % 360

    n = distance / 90
    n.times do 
      tmp = waypointeast
      waypointeast =  waypointnorth * -1
      waypointnorth = tmp
    end
  when "R"
    facingvalue = (facingvalue + distance) % 360
    n = distance / 90
    n.times do 
      tmp = waypointeast
      waypointeast =  waypointnorth
      waypointnorth = tmp * -1
    end
  when "F"
    case facingvalues[facingvalue]
    when 'N'
      northtotal += distance
    when 'E'
      easttotal += distance
    when 'S'
      northtotal -= distance
    when 'W' 
      easttotal -= distance    
    end

    p2easttotal += (waypointeast * distance)
    p2northtotal += (waypointnorth * distance)


  end

  #puts row + " E" + easttotal.to_s + ' N' + northtotal.to_s
  #puts row + " E" + p2easttotal.to_s + ' N' + p2northtotal.to_s + ' WN' + waypointnorth.to_s  + ' WE' + waypointeast.to_s
end

#Part 1
puts (easttotal.abs + northtotal.abs)




#Part 2
puts (p2easttotal.abs + p2northtotal.abs)
