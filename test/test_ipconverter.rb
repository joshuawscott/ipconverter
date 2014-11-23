require 'ipconverter'
require 'minitest/autorun'

class TestIpConverter < MiniTest::Test
  def setup
  end

  def test_smallest_ip
    int = IpConverter.str_to_int "0.0.0.0"
    assert_equal int, 0
  end

  def test_largest_ip
    int = IpConverter.str_to_int "255.255.255.255"
    # maximum 32-bit integer
    assert_equal int, 256 * 256 * 256 * 256 - 1
  end

  def test_handles_spaces
    int = IpConverter.str_to_int " 35.49.102.66 "
    assert_equal int, IpConverter.str_to_int("35.49.102.66")
  end
  def test_no_overflow
    assert_raises(ArgumentError) { IpConverter.str_to_int "12.12.0.256" }
  end

  def test_short_ip
    assert_raises(ArgumentError) { IpConverter.str_to_int "12.34.56" }
  end

  def test_long_ip
    assert_raises(ArgumentError) { IpConverter.str_to_int "12.34.56.78.90" }
  end

  def test_junk
    assert_raises(ArgumentError) { IpConverter.str_to_int "junk" }
  end

end
