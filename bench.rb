require 'benchmark'
require 'ipaddr'
require 'ipconverter'

def ip_to_i(ip)
  ip.split('.').collect(&:to_i).pack('C*').unpack('N').first
end

def ip_to_i2(ip)
  octets = ip.split('.').map(&:to_i)
  octets[3] +
    octets[2] * 256 +
    octets[1] * 256*256 +
    octets[0] * 256*256*256 
end

def ipaddr_to_i(ip)
  IPAddr.new(ip).to_i
end

ips = []
(50..59).each do |o1|
  (155..254).each do |o2|
    (100..199).each do |o3|
      (1..10).each do |o4|
        ips << "#{o1}.#{o2}.#{o3}.#{o4}"
      end
    end
  end
end

puts "iterations: " + ips.length

Benchmark.bmbm do |x|
  x.report('IPAddr#to_i') { ips.each { |ip| IPAddr.new(ip).to_i } }
  x.report('pack/unpack') { ips.each { |ip| ip_to_i(ip) } }
  x.report('split/multiply') { ips.each { |ip| ip_to_i2(ip) } }
  x.report('C split/multiply') { ips.each {|ip| IpConverter.str_to_int(ip) } }
  x.report('noop') { ips.each {|ip| ip } }
end

