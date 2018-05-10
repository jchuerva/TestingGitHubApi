def get_value(item)
  item[1].to_s
end

def get_key(item)
  item[0]
end

def puts_sawyer_resource(sawyer)
  # puts JSON.pretty_generate(sawyer.to_h).gsub(":", " =>")
  puts JSON.pretty_generate(sawyer.to_h).gsub(": ", " => ")
end

def pagination
  puts " "
  puts "-------------------"
  puts " "
end

def continue
  pagination
  print "Press any key to continue\r"
  gets
  pagination
end