import 'dart:convert';

import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:animated_tree_view/tree_view/widgets/expansion_indicator.dart';
import 'package:animated_tree_view/tree_view/widgets/indent.dart';
import 'package:customs/src.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:server_driven_ui/Providers/ui_provider.dart';
import 'package:server_driven_ui/UI/colorPallete.dart';
import 'package:split_view/split_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  final showSnackBar = false;
  final expandChildrenOnReady = true;
  var callBacks;
  TreeViewController? _controller;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    Provider.of<UIProvider>(context, listen: false).widgetProps =
        await Provider.of<UIProvider>(context, listen: false)
            .loadJsonFromAssets('json/widgets.json');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(22, 27, 33, 1),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: sampleTree.expansionNotifier,
        builder: (context, isExpanded, _) {
          return FloatingActionButton.extended(
            onPressed: () {
              if (sampleTree.isExpanded) {
                _controller?.collapseNode(sampleTree);
              } else {
                _controller?.expandAllChildren(sampleTree);
              }
            },
            label: isExpanded
                ? const Text("Collapse all")
                : const Text("Expand all"),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: SplitView(
          gripSize: 1,
          viewMode: SplitViewMode.Horizontal,
          children: [
            Column(
              children: [
                const Text(
                  "Properties",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                if (Provider.of<UIProvider>(context, listen: true)
                        .selectedWidgetData !=
                    null)
                  Expanded(
                    child: ListView.builder(
                      itemCount: Provider.of<UIProvider>(context, listen: true)
                          .selectedWidgetData!["props"]!
                          .keys
                          .length,
                      itemBuilder: (context, index) {
                        final key =
                            Provider.of<UIProvider>(context, listen: true)
                                .selectedWidgetData!["props"]
                                ?.keys
                                .elementAt(index);
                        final List values =
                            (key == "children" || key == "child")
                                ? []
                                : Provider.of<UIProvider>(context, listen: true)
                                        .selectedWidgetData!["props"]?[key]
                                    ["properties"];
                        // print(
                        //     "current value $key ${Provider.of<UIProvider>(context, listen: true).selectedWidgetData!["props"]?[key]} ${Provider.of<UIProvider>(context, listen: true).selectedWidgetData!["props"]?[key]["value"]}");
                        return !(key == "children" || key == "child")
                            ? Center(
                                child: values.isNotEmpty
                                    ? CustomDropDown(
                                        dropDownValue: Provider.of<UIProvider>(
                                                            context,
                                                            listen: true)
                                                        .selectedWidgetData![
                                                    "props"]?[key]["value"] ==
                                                ""
                                            ? null
                                            : Provider.of<UIProvider>(context,
                                                        listen: true)
                                                    .selectedWidgetData![
                                                "props"]?[key]["value"],
                                        dropDownValues: (values as List)
                                            .map((e) => e.toString())
                                            .toList(),
                                        dropDownName: key,
                                        height: 60,
                                        width: 500,
                                        openHeight: 200,
                                        onChanged: (String value) {
                                          callBacks.call(
                                              Provider.of<UIProvider>(context,
                                                      listen: false)
                                                  .selectedWidgetKey,
                                              Provider.of<UIProvider>(context,
                                                      listen: false)
                                                  .selectedWidgetData!["props"]
                                                  ?.keys
                                                  .elementAt(index),
                                              value);
                                          // void updatePropertyValue(
                                          //     String key, TreeNode node) {
                                          //   // if (node.childrenAsList.isEmpty) return;
                                          //   // node.childrenAsList.forEach((element) {
                                          //   //   print("${element.key}");
                                          //   //   if (element.key.toString() == key) {
                                          //   //     print("keyyy $element");
                                          //   //     element.data
                                          //   //     return;
                                          //   //   }
                                          //   // });
                                          // }
                                          // updatePropertyValue(
                                          //     Provider.of<UIProvider>(context, listen: false)
                                          //         .selectedWidgetKey
                                          //         .toString(),
                                          //     node);
                                        },
                                      )
                                    : Center(
                                        child: SizedBox(
                                          height: 60,
                                          width: 500,
                                          child: Card(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0, left: 8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(key),
                                                      Transform(
                                                          transform: Matrix4
                                                              .translationValues(
                                                                  0, -15, 0),
                                                          child: SizedBox(
                                                            height: 20,
                                                            child: Consumer<
                                                                    UIProvider>(
                                                                builder: (context,
                                                                        provider,
                                                                        child) {
                                                                          TextEditingController textEditingController =  TextEditingController(
                                                                           );
                                                                          return
                                                                    TextFormField(
                                                                        controller: textEditingController,
                                                                        onChanged:
                                                                            (value) {
                                                                          callBacks.call(
                                                                              provider.selectedWidgetKey,
                                                                              provider.selectedWidgetData!["props"]?.keys.elementAt(index),
                                                                              value);
                                                                        },
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15),
                                                                        decoration:
                                                                            InputDecoration(
                                                                          suffixIcon:(provider.selectedWidgetData!["props"]?[key]["type"]=="color")? IconButton(
                                                                              onPressed: () {
                                                                                showDialog(
                                                                                  context: context,
                                                                                  builder: (context) {
                                                                                    return AlertDialog(
                                                                                      title: const Text('Pick a color!'),
                                                                                      content: SingleChildScrollView(
                                                                                        child: ColorPicker(
                                                                                          pickerColor: Color(0xff443a49),
                                                                                          onColorChanged: (value) {
                                                                                            textEditingController.text = value.toString();
                                                                                              callBacks.call(
                                                                              provider.selectedWidgetKey,
                                                                              provider.selectedWidgetData!["props"]?.keys.elementAt(index),
                                                                              textEditingController.text);
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                      actions: <Widget>[
                                                                                        ElevatedButton(
                                                                                          child: const Text('Got it'),
                                                                                          onPressed: () {
                                                                                            // setState(() => currentColor = pickerColor);
                                                                                            Navigator.of(context).pop();
                                                                                          },
                                                                                        ),
                                                                                      ],
                                                                                    );
                                                                                  },
                                                                                );
                                                                              },
                                                                              icon: Icon(Icons.color_lens_rounded)):null,
                                                                          contentPadding:
                                                                              EdgeInsets.symmetric(vertical: -5),
                                                                          border:
                                                                              InputBorder.none,
                                                                        ));}),
                                                          )),
                                                    ],
                                                  ))),
                                        ),
                                      ))
                            : null;
                      },
                    ),
                  ),
                TextButton(
                    onPressed: () {
                      TreeNode node = sampleTree;
                      List<dynamic> generateJson(TreeNode widget) {
                        var res = [];

                        if (widget.childrenAsList.isEmpty) return [];
                        widget.children.forEach((key, value) {
                          var name = {
                            "type": (value as TreeNode).data["name"],
                          };
                          var props = {};
                          (value.data["props"] as Map).forEach((key, value) {
                            if (value["value"] != "")
                              props.addAll({key: value["value"]});
                          });
                          if (props["children"] != null)
                            props["children"] = generateJson(value);
                          else {
                            props["child"] = generateJson(value);
                          }
                          res.add({...name, ...props});
                        });
                        return res;
                      }
                    },
                    child: Text("Generate")),
               
              ],
            ),
            TreeView.simple(
              tree: sampleTree,
              showRootNode: false,
              expansionBehavior: ExpansionBehavior.none,
              expansionIndicatorBuilder: (context, node) =>
                  NoExpansionIndicator(tree: node),
              indentation: const Indentation(style: IndentStyle.roundJoint),
              onItemTap: (item) {
                Provider.of<UIProvider>(context, listen: false)
                    .selectedWidgetData = null;
                if (kDebugMode) print("Item tapped: ${item.key}");
                // print(item.data);
                Provider.of<UIProvider>(context, listen: false)
                    .selectedWidgetData = item.data;
                Provider.of<UIProvider>(context, listen: false)
                    .selectedWidgetKey = item.key;
                callBacks = (key, property, value) => {
                      if (item.key == key)
                        {
                          item.data["props"][property]["value"] = value,
                        }
                    };
              },
              onTreeReady: (controller) {
                _controller = controller;
                if (expandChildrenOnReady)
                  controller.expandAllChildren(sampleTree);
              },
              builder: (context, node) => Center(
                child: SizedBox(
                  height: size.height * 0.06,
                  width: size.width * 0.4,
                  child: Card(
                    elevation: 5,
                    shadowColor: Color.fromRGBO(7, 16, 18, 0.4),
                    color: Color.fromRGBO(29, 35, 44, 1),
                    child: Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Transform(
                              transform: Matrix4.translationValues(
                                  size.width * 0.025, -size.height * 0.016, 0),
                              child: TextFormField(
                                initialValue:
                                    "${node.data != null ? node.data["name"] : "Null"}",
                                cursorColor: Colors.white,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  Provider.of<UIProvider>(context,
                                          listen: false)
                                      .selectedWidgetData = null;

                                  Provider.of<UIProvider>(context,
                                          listen: false)
                                      .selectedWidgetKey = null;
                                  if (Provider.of<UIProvider>(context,
                                          listen: false)
                                      .widgetProps!
                                      .keys
                                      .contains(value.toLowerCase())) {
                                    node.data = {
                                      "name": value.toLowerCase(),
                                      "props": jsonDecode(jsonEncode(Provider
                                              .of<UIProvider>(context,
                                                  listen: false)
                                          .widgetProps![value.toLowerCase()])),
                                      "key": node.key
                                    };
                                  } else {
                                    node.data = null;
                                  }
                                },
                                // onSaved: (newValue) {
                                //   Provider.of<UIProvider>(context, listen: false).resultWidgets.a
                                // },
                              ),
                            ),
                          ),
                        ),
                        if (node.data != null &&
                            (node.data["props"] as Map)
                                .keys
                                .contains("child") &&
                            node.childrenAsList.isEmpty)
                          IconButton(
                            icon: Icon(Icons.add_circle_rounded,
                                color: Color.fromRGBO(72, 236, 128, 1)),
                            onPressed: () {
                              TreeNode newNode = TreeNode();
                              node..add(newNode);
                              _controller?.expandAllChildren(sampleTree);
                            },
                          )
                        else if (node.data != null &&
                            (node.data["props"] as Map)
                                .keys
                                .contains("children"))
                          IconButton(
                            icon: Icon(Icons.add_circle_rounded,
                                color: Color.fromRGBO(72, 236, 128, 1)),
                            onPressed: () {
                              TreeNode newNode = TreeNode();
                              node..add(newNode);
                              _controller?.expandAllChildren(sampleTree);
                            },
                          ),
                        IconButton(
                          icon: Icon(Icons.delete,
                              color: Color.fromRGBO(245, 71, 71, 1)),
                          onPressed: () {
                            node.parent!.remove(node);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final sampleTree = TreeNode.root()..add(TreeNode());
