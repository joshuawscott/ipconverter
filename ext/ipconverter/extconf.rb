require 'mkmf'
extension_name = 'ipconverter'
$CFLAGS << ' -I. '
dir_config(extension_name)
create_makefile(extension_name)
