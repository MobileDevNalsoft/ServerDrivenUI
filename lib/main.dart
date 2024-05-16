import 'dart:ui_web';

import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:mirai/mirai.dart';
import 'package:provider/provider.dart';
import 'package:server_driven_ui/Providers/UIProvider.dart';
import 'package:server_driven_ui/UI/DynamicUI.dart';
import 'package:server_driven_ui/UI/MiraiUI.dart';
import 'package:server_driven_ui/UI/home_view.dart';

import 'package:split_view/split_view.dart';

const showSnackBar = false;
const expandChildrenOnReady = true;

void main() {
  runApp(MaterialApp(home: MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => UIProvider(),)],
        child: const HomeView(title: 'Simple Animated Tree Demo')),));
}

