require 'benchmark'

def open_file(num)
  File.open "data/#{num}.txt", 'r'
end
def get_nums(num)
  open_file(num).readlines[0..18000]
end

def sum(l)
  l.inject(0) {|acc, item| acc += item.to_i}
end
def recurse_sum(l)
  recurse_sum_true(l, 0)
end

def recurse_sum_true(l, sum_so_far)
  if l.size == 0
    sum_so_far
  else
    last = l.pop
    recurse_sum_true(l, sum_so_far + l.pop.to_i)
  end
end

def threaded_inject
  t1 = Thread.new do
    sum(get_nums(1))
  end
  t2 = Thread.new do
    sum(get_nums(2))
  end
  t1.join
  t2.join
end
def plain_inject(a, b)
  sum a
  sum b
end  

def threaded_recurse
  t1 = Thread.new do
    recurse_sum(get_nums(3))
  end
  t2 = Thread.new do
    recurse_sum(get_nums(4))
  end
  t1.join
  t2.join
end
def plain_recurse(a, b)
  recurse_sum a 
  recurse_sum b
end

ls = [get_nums(1), get_nums(2), get_nums(3), get_nums(4)]
Benchmark.bmbm do |reporter|
  reporter.report('plain inject') { plain_inject ls[0], ls[1] }
  reporter.report('plain recurse') { plain_recurse ls[0], ls[1] }
  reporter.report('plain recurse 2') { plain_recurse ls[2], ls[3] }
  reporter.report('plain inject 2') { plain_inject ls[2], ls[3] }
end

