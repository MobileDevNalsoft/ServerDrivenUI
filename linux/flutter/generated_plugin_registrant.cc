//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <extract/extract_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) extract_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "ExtractPlugin");
  extract_plugin_register_with_registrar(extract_registrar);
}
