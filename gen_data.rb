f = File.open 'data/2.txt', 'w'
ctr = 0
while ctr < 1000000
  f.puts Random.rand(200)
  ctr += 1
end
f.close
