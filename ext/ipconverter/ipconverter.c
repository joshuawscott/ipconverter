#include <ruby.h>
#include "ipconverter.h"

#define MAX_IP_INT 4294967295

// Module name
VALUE IpConverter = Qnil;

void Init_ipconverter() {
  IpConverter = rb_define_module("IpConverter");
  rb_define_method(IpConverter, "str_to_int", method_str_to_int, 1);
  rb_define_method(IpConverter, "int_to_str", method_int_to_str, 1);
}

/*
 * call-seq:
 *    IpConverter.str_to_int(ip_addr_string) -> Integer
 *
 * Converts the passed IP address String into an Integer.
 *
 * Raises ArgumentError if ip address is not valid.  Leading and trailing
 * whitespace is ignored.
 *
 * Example:
 *    IpConverter.str_to_int("192.168.2.1")
 *      => 3232236033
 *
 */
VALUE method_str_to_int(VALUE _module_, VALUE ip_string) {

  // C string version of the ip_string
  char* c_string = RSTRING_PTR(StringValue(ip_string));

  uint32_t result;

  int success = ip_string_to_long(c_string, &result);

  if (success) {
    // Convert the uint32_t back to a ruby Integer.
    return UINT2NUM(result);
  } else {
    rb_raise(rb_eArgError, "Invalid IP Address String");
  }
}

// Returns 0 if ip is invalid; 1 otherwise.
// takes an ip address string, like "192.168.2.254", finds the 32-bit integer
// value and stores that in result.
static int
ip_string_to_long(char c_string[], uint32_t *result) {
  uint32_t i, found_octets;
  char junk;
  uint32_t octets[4];

  found_octets = sscanf((char*)c_string, "%d.%d.%d.%d%c", (int*)&octets[3], (int*)&octets[2], (int*)&octets[1], (int*)&octets[0], &junk);

  // If we didn't find exactly 4 octets, bail out, unless the extra is whitespace
  if (found_octets != 4
      && !(found_octets == 5 && junk == ' ')) {
    return 0;
  }

  // If any of the octets are not in-range, bail out
  for (i = 0; i < 4; i++) {
    if (octets[i] > 255) {
      return 0;
    }
  }

  *result = (octets[0] + octets[1] * 256 + octets[2] * 256 * 256 + octets[3] * 256 * 256 * 256);
  return 1;
}

/*
 * call-seq:
 *    IpConverter.int_to_str(ip_addr_integer) -> String
 *
 * Converts the passed integer into an IPv4 address string.
 *
 * Raises ArugmentError if number is negative, or greater than the maximum
 * possible value for an IPv4 address (4294967295)
 *
 * Example:
 *    IpConverter.int_to_str(3232236033)
 *      => "192.168.2.1"
 *
 */
VALUE
method_int_to_str(VALUE _module_, VALUE ip_integer) {
  char c_string[16];
  int64_t ip = NUM2LL(ip_integer);
  if (ip > MAX_IP_INT || ip < 0) {
     rb_raise(rb_eArgError, "IP address integer out of range");
  }
  ip_long_to_string((uint32_t)ip, c_string);
  return rb_str_new2(c_string);
}

// This one is a void because the bounds checking is done with the uint32_t
// type already.
static void
ip_long_to_string(uint32_t ip, char c_string[]) {
  uint8_t bytes[4];
  bytes[0] = ip & 0xFF;
  bytes[1] = (ip >> 8) & 0xFF;
  bytes[2] = (ip >> 16) & 0xFF;
  bytes[3] = (ip >> 24) & 0xFF;

  sprintf(c_string, "%d.%d.%d.%d", bytes[3], bytes[2], bytes[1], bytes[0]);
}
