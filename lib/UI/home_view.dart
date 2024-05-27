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
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:provider/provider.dart';
import 'package:server_driven_ui/Providers/ui_provider.dart';
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
    Provider.of<UIProvider>(context, listen: false).widgets =
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
                    child: 
                    customListViewBuilder(Provider.of<UIProvider>(context, listen: true)
                        .selectedWidgetData!["props"],level: 0)
                    // ListView.builder(
                    //   itemCount: Provider.of<UIProvider>(context, listen: true)
                    //       .selectedWidgetData!["props"]!
                    //       .keys
                    //       .length,
                    //   itemBuilder: (context, index) {
                    //     final key =
                    //         Provider.of<UIProvider>(context, listen: true)
                    //             .selectedWidgetData!["props"]
                    //             ?.keys
                    //             .elementAt(index);
                    //     final List values =
                    //         (key == "children" || key == "child")
                    //             ? []
                    //             : Provider.of<UIProvider>(context, listen: true)
                    //                     .selectedWidgetData!["props"]?[key]
                    //                 ["properties"];
                    //     return !(key == "children" || key == "child")
                    //         ? Center(
                    //             child: values.isNotEmpty
                    //                 ? CustomDropDown(
                    //                     dropDownValue: Provider.of<UIProvider>(
                    //                                         context,
                    //                                         listen: true)
                    //                                     .selectedWidgetData![
                    //                                 "props"]?[key]["value"] ==
                    //                             ""
                    //                         ? null
                    //                         : Provider.of<UIProvider>(context,
                    //                                     listen: true)
                    //                                 .selectedWidgetData![
                    //                             "props"]?[key]["value"],
                    //                     dropDownValues: (values as List)
                    //                         .map((e) => e.toString())
                    //                         .toList(),
                    //                     dropDownName: key,
                    //                     height: 60,
                    //                     width: 300,
                    //                     openHeight: 60 + values.length * 36,
                    //                     onChanged: (String value) {
                    //                       callBacks.call(
                    //                           Provider.of<UIProvider>(context,
                    //                                   listen: false)
                    //                               .selectedWidgetKey,
                    //                           Provider.of<UIProvider>(context,
                    //                                   listen: false)
                    //                               .selectedWidgetData!["props"]
                    //                               ?.keys
                    //                               .elementAt(index),
                    //                           value);
                    //                     },
                    //                   )
                    //                 : Center(
                    //                     child: SizedBox(
                    //                       height: 60,
                    //                       width: 300,
                    //                       child: Card(
                    //                           child: Padding(
                    //                               padding:
                    //                                   const EdgeInsets.only(
                    //                                       top: 8.0, left: 8.0),
                    //                               child: Column(
                    //                                 crossAxisAlignment:
                    //                                     CrossAxisAlignment
                    //                                         .start,
                    //                                 children: [
                    //                                   Transform(
                    //                                       transform: Matrix4
                    //                                           .translationValues(
                    //                                               0, -4, 0),
                    //                                       child: Text(
                    //                                         key,style: TextStyle(),
                    //                                       )),
                    //                                   Transform(
                    //                                       transform: Matrix4
                    //                                           .translationValues(
                    //                                               4, -15, 0),
                    //                                       child: SizedBox(
                    //                                         height: 20,
                    //                                         child: Consumer<
                    //                                                 UIProvider>(
                    //                                             builder:
                    //                                                 (context,
                    //                                                     provider,
                    //                                                     child) {
                    //                                           TextEditingController
                    //                                               textEditingController =
                    //                                               TextEditingController(
                    //                                                   text: provider.selectedWidgetData!["props"]
                    //                                                           ?[
                    //                                                           key]
                    //                                                       [
                    //                                                       "value"]);
                    //                                           textEditingController
                    //                                                   .selection =
                    //                                               TextSelection.fromPosition(TextPosition(
                    //                                                   offset: textEditingController
                    //                                                       .text
                    //                                                       .length));

                    //                                           return Row(
                    //                                             children: [
                    //                                               Expanded(
                    //                                                 child: TextFormField(
                    //                                                     controller: textEditingController,
                    //                                                     onChanged: (value) {
                    //                                                       callBacks.call(
                    //                                                           provider.selectedWidgetKey,
                    //                                                           provider.selectedWidgetData!["props"]?.keys.elementAt(index),
                    //                                                           value);
                    //                                                     },
                    //                                                     style: TextStyle(
                    //                                                       fontSize:
                    //                                                           15,
                    //                                                     ),
                    //                                                     decoration: InputDecoration(
                    //                                                       prefixIcon: (provider.selectedWidgetData!["props"]?[key]["type"] == "color")
                    //                                                           ? Transform(
                    //                                                               transform: Matrix4.translationValues(0, 10, 0),
                    //                                                               child: Icon(
                    //                                                                 Icons.circle_rounded,
                    //                                                                 color: colorFromHex(provider.selectedWidgetData?["props"]?[key]["value"]),
                    //                                                               ))
                    //                                                           : null,
                    //                                                       suffixIcon: (provider.selectedWidgetData!["props"]?[key]["type"] == "color")
                    //                                                           ? InkWell(
                    //                                                               child: Icon(Icons.color_lens_rounded),
                    //                                                               onTap: () {
                    //                                                                 showDialog(
                    //                                                                   context: context,
                    //                                                                   builder: (context) {
                    //                                                                     return AlertDialog(
                    //                                                                       title: const Text('Pick a color!'),
                    //                                                                       content: SingleChildScrollView(
                    //                                                                         child: ColorPicker(
                    //                                                                           pickerColor: Color(0xff443a49),
                    //                                                                           onColorChanged: (value) {
                    //                                                                             print(value.toHexString());
                    //                                                                             textEditingController.text = value.toHexString();
                    //                                                                           },
                    //                                                                         ),
                    //                                                                       ),
                    //                                                                       actions: <Widget>[
                    //                                                                         ElevatedButton(
                    //                                                                           child: const Text('Ok'),
                    //                                                                           onPressed: () {
                    //                                                                             callBacks.call(provider.selectedWidgetKey, provider.selectedWidgetData!["props"]?.keys.elementAt(index), textEditingController.text);
                    //                                                                             Navigator.of(context).pop();
                    //                                                                           },
                    //                                                                         ),
                    //                                                                       ],
                    //                                                                     );
                    //                                                                   },
                    //                                                                 );
                    //                                                               },
                    //                                                             )
                    //                                                           : null,
                    //                                                       contentPadding:
                    //                                                           EdgeInsets.symmetric(vertical: 0),
                    //                                                       border:
                    //                                                           InputBorder.none,
                    //                                                     )),
                    //                                               ),
                    //                                             ],
                    //                                           );
                    //                                         }),
                    //                                       )),
                    //                                 ],
                    //                               ))),
                    //                     ),
                    //                   ))
                    //         : null;
                    //   },
                    // ),
                  
                  ),
                TextButton(
                    onPressed: () {
                      TreeNode node = sampleTree;
                      // var json={};
                      generateInternalJson(Map internalProps){
                        print("inside internaljson $internalProps");
                        var internalJson={};
                        internalProps.forEach((key, value) {
                          print("key $key");
                          print("value ${value}");

                          (value as Map).forEach((propKey,propValue){
                            if(propValue["value"]!=""){
                              if(propValue["type"]!="widget"){
                                (internalJson[key] as Map).addAll({propKey:propValue["value"]});
                              }
                              else{
                                var nestedJson = generateInternalJson(propValue["value"]);
                                internalJson.addAll({key:{propKey:nestedJson}});
                              }
                            }
                          });
                          
                        } );
                        print(internalJson);
                        return internalJson;
                      }    



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
                              print(value["value"].runtimeType);
                              if(value["value"].runtimeType.toString()=="IdentityMap<String, dynamic>"){
                                var internalJson = generateInternalJson(value["value"]);
                                props.addAll({key:internalJson});
                              } 
                              else{

                              props.addAll({key: value["value"]});
                              }
                          });
                          if (props.containsKey("children"))
                            props["children"] = generateJson(value);
                          else {
                            props["child"] = generateJson(value).isEmpty
                                ? {}
                                : generateJson(value)[0];
                          }
                          res.add({...name, ...props});
                        });
                        return res;
                      }

                      print(generateJson(node));
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
                callBacks = (key, property, value) {
                  // if (item.key == key) {
                  //   item.data["props"][property]["value"] = value;
                    Provider.of<UIProvider>(context, listen: false)
                        .selectedWidgetData = item.data;
                  // }
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
                                      .widgets!
                                      .keys
                                      .contains(value.toLowerCase())) {
                                    node.data = {
                                      "name": value.toLowerCase(),
                                      "props": jsonDecode(jsonEncode(Provider
                                              .of<UIProvider>(context,
                                                  listen: false)
                                          .widgets![value.toLowerCase()])),
                                      "key": node.key
                                    };
                                  } else {
                                    node.data = null;
                                  }
                                },
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

  Widget customListViewBuilder(Map data,{String? type,String? widget="",required int  level}){
    
    // if(type=="widget"){
    
   
    // print(Provider.of<UIProvider>(context, listen: false).selectedWidgetData);
    // print("itemcount ${data["value"].keys.length}") ;}
     print("data $data");
    return   ScrollbarTheme(
       data: ScrollbarThemeData(
    thumbColor: WidgetStateProperty.all<Color>(Colors.white), // Set the color of the scrollbar thumb
    trackColor: WidgetStateProperty.all<Color>(Colors.grey.withOpacity(0.5)), // Set the color of the scrollbar track
    thickness: WidgetStateProperty.all<double>(3), // Set the thickness of the scrollbar
    radius: const Radius.circular(2), // Set the radius of the scrollbar corners
  ),
      child: Scrollbar(
        child: ListView.builder(
          
                          itemCount:data.keys.length,
                          itemBuilder: (context, index) {
                            final key =
                                data.keys.elementAt(index);
                              print("keyyy $key");
                            // print("type ${data[key]["type"]}");
                            String? widgetType =(data[key]["type"]);
                            print("widgetType $widgetType");
                            if(widgetType == "widget"){
                              level=level+1;
                              print(Provider.of<UIProvider>(context, listen: false).widgets![data[key]["widget"].toLowerCase()]);
                                data[key]["value"] ={ data[key]["widget"].toString().toLowerCase():Provider.of<UIProvider>(context, listen: false).widgets![data[key]["widget"].toLowerCase()]};
                                print(data);
                            }
        
        
        
                             List values =[];
                                if (data[key]["properties"]!=null){
                                  values = data[key]["properties"];
                                }
                            return !(key == "children" || key == "child")
                                ? Center(
                                    child: 
                                    switch (widgetType) {
                                      "dropdown"  =>   CustomDropDown(
                                            dropDownValue:   data[key]["value"]==""?null:data[key]["value"],
                                            dropDownValues: (values as List)
                                                .map((e) => e.toString())
                                                .toList(),
                                            dropDownName: key,
                                            height: 60,
                                            width: 300,
                                            openHeight: 60 + values.length * 36,
                                            onChanged: (String value) {
                                               (data[key]["value"]=value);
                                            print(Provider.of<UIProvider>(context, listen: false).selectedWidgetData);
                                            }
                                            ,
                                          ),
                                          
                                       "textfield"||"color"||"number"=>  Center(
                                            child: SizedBox(
                                              height: 60,
                                              width: 300,
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
                                                          Transform(
                                                              transform: Matrix4
                                                                  .translationValues(
                                                                      0, -4, 0),
                                                              child: Text(
                                                                key,
                                                              )),
                                                          Transform(
                                                              transform: Matrix4
                                                                  .translationValues(
                                                                      4, -15, 0),
                                                              child: SizedBox(
                                                                height: 20,
                                                                child: Consumer<
                                                                        UIProvider>(
                                                                    builder:
                                                                        (context,
                                                                            provider,
                                                                            child) {
                                                                  TextEditingController
                                                                      textEditingController =
                                                                      TextEditingController(
                                                                          text:   data[key]["value"]);
                                                                  textEditingController
                                                                          .selection =
                                                                      TextSelection.fromPosition(TextPosition(
                                                                          offset: textEditingController
                                                                              .text
                                                                              .length));
                                                                  return Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child: TextFormField(
                                                                          validator: (value) => (widgetType!="number")? "only numbers are accepted":null,
                                                                            controller: textEditingController,
                                                                            onChanged: (value) {
                                                                             data[key]["value"]=value;
                                                                            },
                                                                            style: TextStyle(
                                                                              fontSize:
                                                                                  15,
                                                                            ),
                                                                            decoration: InputDecoration(
                                                                              prefixIcon: (widgetType == "color")
                                                                                  ? Transform(
                                                                                      transform: Matrix4.translationValues(0, 10, 0),
                                                                                      child: Icon(
                                                                                        Icons.circle_rounded,
                                                                                        color: colorFromHex(textEditingController.text),
                                                                                      ))
                                                                                  : null,
                                                                              suffixIcon: (widgetType == "color")
                                                                                  ? InkWell(
                                                                                      child: Icon(Icons.color_lens_rounded),
                                                                                       onTap: () {
                                                                                        showDialog(
                                                                                          context: context,
                                                                                          builder: (context) {
                                                                                            return AlertDialog(
                                                                                              title: const Text('Pick a color!'),
                                                                                              content: SingleChildScrollView(
                                                                                                child: ColorPicker(
                                                                                                  pickerColor: Color(0xff443a49),
                                                                                                  onColorChanged: (value) {
                                                                                                    print(value.toHexString());
                                                                                                    textEditingController.text = value.toHexString();
                                                                                                     data[key]["value"]= value.toHexString();
                                                                                                  },
                                                                                                ),
                                                                                              ),
                                                                                              actions: <Widget>[
                                                                                                ElevatedButton(
                                                                                                  child: const Text('Ok'),
                                                                                                  onPressed: () {
                                                                                                    
                                                                                                     data[key]["value"]=textEditingController.text;
                                                                                                    callBacks.call(provider.selectedWidgetKey, provider.selectedWidgetData!["props"]?.keys.elementAt(index), textEditingController.text);
                                                                                                    
                                                                                                    Navigator.of(context).pop();
                                                                                                  },
                                                                                                ),
                                                                                              ],
                                                                                            );
                                                                                          },
                                                                                        );
                                                                                      },
                                                                                    )
                                                                                  : null,
                                                                              contentPadding:
                                                                                  EdgeInsets.symmetric(vertical: 0),
                                                                              border:
                                                                                  InputBorder.none,
                                                                            )),
                                                                      ),
                                                                    ],
                                                                  );
                                                                }),
                                                              )),
                                                        ],
                                                      ))),
                                            ),
                                          ),
        
                                        "widget"=>Expanded(
                                          
                                          child: SizedBox(
                                            height: data[key]["value"][data[key]["widget"].toLowerCase()].keys.length<=3?
                                            data[key]["value"][data[key]["widget"].toLowerCase()].keys.length*100: 
                                            data[key]["value"][data[key]["widget"].toLowerCase()].keys.length*40,
                                            width: 500 - (level*10),
                                            child: Card(
                                              elevation: 5,
                                              color: Color.fromRGBO((level*2)+29, 35, 44, 1),
                                              shadowColor: Colors.white,
                                              // color: Color.fromRGBO(level*90, 180, 180, 1),
                                              child: Column(
                                                children: [
                                                  Text(key,style: TextStyle(color: Colors.white),),
                                                  Expanded(
                                                    child: 
                                                        customListViewBuilder( data[key]["value"][data[key]["widget"].toLowerCase()],level: level!+1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      // TODO: Handle this case.
                                      null||Object() => SizedBox(),
                                      
                                     
                                    } )
                                : SizedBox();
                          },
                        ),
      ),
    );
                  
  }

}

final sampleTree = TreeNode.root()..add(TreeNode());
