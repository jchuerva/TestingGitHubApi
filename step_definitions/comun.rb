def get_value(item)
  item[1].to_s
end

def get_key(item)
  item[0]
end

def puts_hash(hash)
  hash.each do |key, value|
    puts "#{key} : #{value}"
  end
end

def pagination
  puts " "
  puts "-------------------"
  puts " "
end