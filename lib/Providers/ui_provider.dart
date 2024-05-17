import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UIProvider extends ChangeNotifier {

  Map? _selectedWidget;
  Map? _widgetProps;
  Map? _selectedWidgetData;

  Map? get selectedWidgetData => _selectedWidgetData;
  Map? get selectedWidget => _selectedWidget;
  Map? resultWidgets;



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

  Future loadJsonFromAssets(String path)async{
    var data = await rootBundle.loadString(path);
       return jsonDecode(data)["widgets"];
  }

}
