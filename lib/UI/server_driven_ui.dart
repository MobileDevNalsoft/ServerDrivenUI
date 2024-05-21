import 'package:flutter/material.dart';
import 'package:serve_dynamic_ui/serve_dynamic_ui.dart';

class ServerDrivenUI extends StatefulWidget {
  const ServerDrivenUI({super.key});

  @override
  State<ServerDrivenUI> createState() => _ServerDrivenUIState();
}

class _ServerDrivenUIState extends State<ServerDrivenUI> {
  @override
  Widget build(BuildContext context) {
    return ServeDynamicUIMaterialApp(home: (context) {
      return ServeDynamicUI.fromAssets("assets/json/sample.json");
    });
  }
}
