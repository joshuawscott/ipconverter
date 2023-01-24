# frozen_string_literal: true

require 'ipconverter/version'
require 'ipconverter'

# Contains the methods for doing IP Address conversions
#
# Example:
#     IpConverter.str_to_int('192.168.2.1') # 3232236033
#
module IpConverter
  module_function :str_to_int
  module_function :int_to_str
end
