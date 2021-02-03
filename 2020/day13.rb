require './inputs'

input = Inputs::DAY13

bustimes = input.split("\n")
arrival = bustimes[0].to_i
timetable = bustimes[1].split(',')
timetable.delete('x')

departure = arrival - 1
busid = departure
calculate = true

while calculate == true
  departure += 1
  timetable.map(&:to_i).each do |time|
    #puts departure.to_s + ' ' + time.to_s + ' ' + (departure % time).to_s
    if (departure % time == 0)
      busid = time
      calculate = false
    end    
  end
end


#Part 1
result = (departure - arrival) * busid
puts result

#Part 2
timetable = bustimes[1].split(',')

starttime = 1
increment = 1
timetable.each_with_index do |time, i|
  next if time == 'x'

  time = time.to_i
  while true
    if (starttime + i) % time == 0 
      increment *= time
      break;
    end
    starttime += increment;
  end
end

puts starttime

