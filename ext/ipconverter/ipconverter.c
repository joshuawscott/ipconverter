#include <ruby.h>
#include "ipconverter.h"

// Module name
VALUE IpConverter = Qnil;

void Init_ipconverter() {
  IpConverter = rb_define_module("IpConverter");
  rb_define_method(IpConverter, "str_to_int", method_str_to_int, 1);
}

// Converts a passed ruby string into an integer
// returns integer or nil (if ip is invalid)
VALUE method_str_to_int(VALUE _module_, VALUE ip_string) {

  // C string version of the ip_string
  char* c_string = RSTRING_PTR(StringValue(ip_string));

  uint32_t result;

  int success = ip_string_to_long(c_string, &result);

  if (success) {
    // Convert the uint32_t back to a ruby Fixnum.
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
  int32_t i, found_octets;
  char junk;
  int32_t octets[4];

  found_octets = sscanf((char*)c_string, "%d.%d.%d.%d%c", (int*)&octets[3], (int*)&octets[2], (int*)&octets[1], (int*)&octets[0], &junk);

  // If we didn't find exactly 4 octets, bail out, unless the extra is whitespace
  if (found_octets != 4 
      && !(found_octets == 5 && junk == ' ')) {
    return 0;
  }

  // If any of the octets are not in-range, bail out
  for (i = 0; i < 4; i++) {
    if (octets[i] > 255 || octets[i] < 0) {
      return 0;
    }
  }

  *result = (octets[0] + octets[1] * 256 + octets[2] * 256 * 256 + octets[3] * 256 * 256 * 256);
  return 1;
}

