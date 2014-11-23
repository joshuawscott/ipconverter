require 'benchmark'
require 'ipaddr'
require 'ipconverter'

def ruby_shift(ip)
  [
    (ip >> 24) & 255,
    (ip >> 16) & 255,
    (ip >> 8) & 255,
    (ip >> 0) & 255
  ].join('.')
end

ips = 0..999999

puts 'iterations: 1,000,000'

Benchmark.bmbm do |x|
  x.report('IPAddr#to_s') { ips.each { |ip| IPAddr.new(ip, Socket::AF_INET).to_s } }
  x.report('Ruby shifts') { ips.each { |ip| ruby_shift(ip) } }
  x.report('C shifts') { ips.each { |ip| IpConverter.int_to_str(ip) } }
  x.report('noop') { ips.each { |ip| ip } }
end
