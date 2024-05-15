import 'package:flutter/material.dart';
import 'package:mirai/mirai.dart';
import 'package:provider/provider.dart';
import 'package:server_driven_ui/Providers/UIProvider.dart';
import 'package:server_driven_ui/UI/DynamicUI.dart';
import 'package:server_driven_ui/UI/MiraiUI.dart';

void main() async {
  await Mirai.initialize();

  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UIProvider())],
      child: const DynamicUI()));
}
