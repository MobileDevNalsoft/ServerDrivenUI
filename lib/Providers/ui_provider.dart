import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UIProvider extends ChangeNotifier {

  Map? _selectedWidget;
  Map? _widgetProps;
  Map? _selectedWidgetData;
  String? _selectedWidgetKey;


  Map? get selectedWidgetData => _selectedWidgetData;
  Map? get selectedWidget => _selectedWidget;
  String? get selectedWidgetKey => _selectedWidgetKey;
  Map? get widgetProps => _widgetProps;
  set widgetProps(value){
    _widgetProps =value;
    // notifyListeners();
  }
  set selectedWidget(value) {
    _selectedWidget = value;
    notifyListeners();
  }

  set selectedWidgetData(value) {
    _selectedWidgetData = value;
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
