import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UIProvider extends ChangeNotifier {

  String? _selectedWidget;
  Map? _widgetProps;
  String? get selectedWidget => _selectedWidget;

  get widgetProps => _widgetProps;
  set widgetProps(value){
    _widgetProps =value;
    notifyListeners();
  }
  set selectedWidget(value) {
    _selectedWidget = value;
    notifyListeners();
  }

  Future loadJsonFromAssets(String path)async{
    var data = await rootBundle.loadString(path);
      print(jsonDecode(data)["widgets"][selectedWidget!.toLowerCase()]);
       return jsonDecode(data)["widgets"][selectedWidget!.toLowerCase()];
  }

}
