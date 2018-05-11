def puts_sawyer_resource(sawyer)
  puts JSON.pretty_generate(sawyer.to_h).gsub(': ', ' => ')
end

def pretty_format(input)
  puts JSON.pretty_generate(input)
end

def pagination
  puts ' '
  puts '-------------------'
  puts ' '
end

def continue
  pagination
  print "Press any key to continue\r"
  gets
  pagination
end
