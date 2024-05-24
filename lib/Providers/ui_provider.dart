import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UIProvider extends ChangeNotifier {

  Map? _widgetProps;
  Map? _selectedWidgetData;
  String? _selectedWidgetKey;


  Map? get selectedWidgetData => _selectedWidgetData;

  String? get selectedWidgetKey => _selectedWidgetKey;
  Map? get widgets => _widgetProps;
  set widgets(value){
    _widgetProps =value;
    // notifyListeners();
  }


  set selectedWidgetData(value) {
    _selectedWidgetData = value;
    print("selected widget data from provider $_selectedWidgetData");
    notifyListeners();
  }


  set selectedWidgetKey(value) {
    _selectedWidgetKey = value;
    notifyListeners();
  }

  Future loadJsonFromAssets(String path)async{
    var data = await rootBundle.loadString(path);
       return jsonDecode(data)["widgets"];
  }

}
