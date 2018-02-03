require 'benchmark'
require 'ipaddr'
require 'ipconverter'

def self.pack_unpack(ip)
  ip.split('.').collect(&:to_i).pack('C*').unpack('N').first
end

# rubocop:disable AbcSize
def self.split_multiply(ip)
  octets = ip.split('.').map(&:to_i)
  octets[3] +
    octets[2] * 256 +
    octets[1] * 256 * 256 +
    octets[0] * 256 * 256 * 256
end
# rubocop:enable AbcSize

def self.ipaddr_to_i(ip)
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

puts 'iterations: 1,000,000'

Benchmark.bmbm do |x|
  x.report('IPAddr#to_i') { ips.each { |ip| IPAddr.new(ip).to_i } }
  x.report('pack/unpack') { ips.each { |ip| pack_unpack(ip) } }
  x.report('split/multiply') { ips.each { |ip| split_multiply(ip) } }
  x.report('IpConverter') { ips.each { |ip| IpConverter.str_to_int(ip) } }
  x.report('noop') { ips.each { |ip| ip } }
end
