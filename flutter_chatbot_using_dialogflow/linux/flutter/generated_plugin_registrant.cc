//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <dialogflow_grpc/dialogflow_grpc_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) dialogflow_grpc_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "DialogflowGrpcPlugin");
  dialogflow_grpc_plugin_register_with_registrar(dialogflow_grpc_registrar);
}
