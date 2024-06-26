import 'package:flutter/material.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:provider/provider.dart';
import 'package:server_driven_ui/Providers/ui_provider.dart';
import 'package:server_driven_ui/UI/home_view.dart';
const showSnackBar = false;
const expandChildrenOnReady = true;

void main() {
  // ServeDynamicUI.init();

  runApp(MaterialApp(
    home: MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => UIProvider(),
      )
    ], child:  HomeView(title: '',)),
  ));
}
