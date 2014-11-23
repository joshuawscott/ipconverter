VALUE method_str_to_int(VALUE, VALUE);
static int ip_string_to_long(char[], uint32_t*);

VALUE method_int_to_str(VALUE, VALUE);
static void ip_long_to_string(uint32_t, char[]);

void Init_ipconverter();
