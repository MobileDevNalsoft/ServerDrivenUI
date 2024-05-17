import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

class DynamicUI extends StatefulWidget {
  const DynamicUI({super.key});

  @override
  State<DynamicUI> createState() => _DynamicUIState();
}

class _DynamicUIState extends State<DynamicUI> {
  @override
  Widget build(BuildContext context) {
    const jsonData = '''
    {
      "type": "scaffold",
      "properties":{
        "app_bar":{
          "title":{
            "type":"text",
            "text": "Hello World"
          },
          "center_title":"true"
        }
      },
      "child": {
        "type": "column",
        "children": [
          {
            "type":"text",
            "properties":{
              "style":{
                "fontWeight":"bold"
              }
            },
            "text":"child 1"
          },
          {
            "type":"text",
            "properties":{
              "style":{
                "fontWeight":"bold"
              }
            },
            "text":"child 2"
          }
        ]
      }
    }
    ''';

    final dynamic parsedJson = jsonDecode(jsonData);
    final Widget widget = buildWidget(parsedJson);

    return MaterialApp(home: widget);
  }

  Widget buildWidget(dynamic json) {
    List<Widget>? children = [];

    switch (json['type']) {
      case 'scaffold':
        if (json['properties']['app_bar']['actions'] != null) {
          for (var child in json['properties']['app_bar']['actions']) {
            children.add(buildWidget(child));
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: buildWidget(json['properties']['app_bar']['title']),
            centerTitle:
                bool.parse(json['properties']['app_bar']['center_title']),
            actions: children,
            backgroundColor: json['background_color'] != null
                ? Color(int.parse(json['background_color'].substring(1, 7),
                        radix: 16) +
                    0xFF000000)
                : null,
            foregroundColor: json['foreground_color'] != null
                ? Color(int.parse(json['foreground_color'].substring(1, 7),
                        radix: 16) +
                    0xFF000000)
                : null,
            leading:
                json['leading'] != null ? buildWidget(json['leading']) : null,
            leadingWidth: json['leadingWidth'] != null
                ? double.parse(json['leadingWidth'])
                : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(json['border_radius'] != null
                  ? double.parse(json['border_radius'])
                  : 0), // in pixel
            ),
          ),
          backgroundColor: json['background_color'] != null
              ? Color(int.parse(json['background_color'].substring(1, 7),
                      radix: 16) +
                  0xFF000000)
              : null,
          floatingActionButton: json['floating_action_button'] != null
              ? buildWidget(json['floating_action_button'])
              : null,
          body: buildWidget(json['child']),
        );

      case 'center':
        return Center(child: buildWidget(json['child']));

      case 'circular_progress_indicator':
        return CircularProgressIndicator(
          color: Color(
              int.parse(json['color'].substring(1, 7), radix: 16) + 0xFF000000),
        );

      case 'text':
        return Text(
          json['text'],
          style: TextStyle(
              fontWeight: json['fontWeight'] == 'bold'
                  ? FontWeight.bold
                  : FontWeight.normal),
        );

      case 'column':
        for (var child in json['children']) {
          children.add(buildWidget(child));
        }

        MainAxisAlignment? mainAxisAlignment;
        switch (json['main_axis_alignment']) {
          case 'start':
            mainAxisAlignment = MainAxisAlignment.start;
          case 'end':
            mainAxisAlignment = MainAxisAlignment.end;
          case 'space_around':
            mainAxisAlignment = MainAxisAlignment.spaceAround;
          case 'space_evenly':
            mainAxisAlignment = MainAxisAlignment.spaceEvenly;
          case 'space_between':
            mainAxisAlignment = MainAxisAlignment.spaceBetween;
        }

        return Column(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          children: children,
        );

      default:
        return SizedBox();
    }
  }
}
