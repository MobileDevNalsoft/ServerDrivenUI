// import 'dart:html';
// import 'dart:ui_web';

// import 'package:animated_tree_view/animated_tree_view.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:json_dynamic_widget/json_dynamic_widget.dart';
// import 'package:provider/provider.dart';
// import 'package:server_driven_ui/Providers/UIProvider.dart';

// import 'package:split_view/split_view.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   HomeViewState createState() => HomeViewState();
// }

// class HomeViewState extends State<HomeView> {
//   final showSnackBar = false;
//   final expandChildrenOnReady = true;
 
//   TreeViewController? _controller;
//   @override
//   void initState() {}

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(22, 27, 33, 1),
//       floatingActionButton: ValueListenableBuilder<bool>(
//         valueListenable: sampleTree.expansionNotifier,
//         builder: (context, isExpanded, _) {
//           return FloatingActionButton.extended(
//             onPressed: () {
//               if (sampleTree.isExpanded) {
//                 _controller?.collapseNode(sampleTree);
//               } else {
//                 _controller?.expandAllChildren(sampleTree);
//               }
//             },
//             label: isExpanded
//                 ? const Text("Collapse all")
//                 : const Text("Expand all"),
//           );
//         },
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 16.0),
//         child: SplitView(
//           // controller: SplitViewController(limits: [WeightLimit(max: 0.2),WeightLimit(max: 0.8)]),
//           gripSize: 1,
//           viewMode: SplitViewMode.Horizontal,
//           children: [
//             Column(
//               children: [
//                 Text(
//                   "Properties",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 if (Provider.of<UIProvider>(context, listen: true).widgetProps !=
//                     null)

//                   Container(
                    
//                     height: size.height*0.8,
//                     child: ListView.builder(
//                       itemCount: Provider.of<UIProvider>(context, listen: false).widgetProps!.keys.length ,
//                       itemBuilder: (context, index) {
//                         print("index $index");
//                         print("Provider.of<UIProvider>(context, listen: false).widgetprops $Provider.of<UIProvider>(context, listen: false).widgetProps");
//                         final key = Provider.of<UIProvider>(context, listen: false).widgetProps?.keys.elementAt(index);
//                         final values = Provider.of<UIProvider>(context, listen: false).widgetProps?[key];
//                         print("key $key value $values");
//                         List<DropdownMenuItem<String>>? dropdownItems = [];

//                         // if (value is Map) {
//                         //   print("value $value");
//                         //   dropdownItems = value.keys
//                         //       .map((dropdownKey) {
//                         //         return DropdownMenuItem(
//                         //           value: dropdownKey,
//                         //           child: Text(value[dropdownKey] ?? ''),
//                         //         );
//                         //       })
//                         //       .cast<DropdownMenuItem<String>>()
//                         //       .toList();
//                         // }
//                         for(var value in values){
//                           dropdownItems.add(DropdownMenuItem(child: Text(value),value: value,));
//                         }
//                         print(dropdownItems);
//                         return Container(
                        
//                           child: DropdownButton(
                            
//                             items: dropdownItems,
//                             onChanged: (selectedValue) {
//                               // Handle dropdown value change
//                             },
//                           ),
//                         );
//                       },
//                     ),
//                   )
//               ],
//             ),
//             TreeView.simple(
//               tree: sampleTree,
//               showRootNode: false,
//               expansionBehavior: ExpansionBehavior.none,
//               expansionIndicatorBuilder: (context, node) =>
//                   NoExpansionIndicator(tree: node),
//               indentation: const Indentation(style: IndentStyle.roundJoint),
              
//               onItemTap: (item) async{
//                 if (kDebugMode) print("Item tapped: ${item.key}");
//                 print("children ${item.childrenAsList}");
//                 Provider.of<UIProvider>(context, listen: false).selectedWidget =
//                     item.data;
//                 Provider.of<UIProvider>(context, listen: false).widgetProps = await Provider.of<UIProvider>(context, listen: false).loadJsonFromAssets("json/widgets.json");
//                 print(
//                     "item ${Provider.of<UIProvider>(context, listen: false).selectedWidget}");
//                     print(Provider.of<UIProvider>(context, listen: false).widgetProps);
//               },
              
//               onTreeReady: (controller) {
//                 _controller = controller;
//                 if (expandChildrenOnReady)
//                   controller.expandAllChildren(sampleTree);
//               },
//               builder: (context, node) => Center(
//                 child: SizedBox(
//                   height: size.height * 0.06,
//                   width: size.width * 0.4,
//                   child: Card(
//                     elevation: 5,
//                     shadowColor: Color.fromRGBO(7, 16, 18, 0.4),
//                     color: Color.fromRGBO(29, 35, 44, 1),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: ListTile(
//                             title: Transform(
//                               transform: Matrix4.translationValues(
//                                   size.width * 0.025, -size.height * 0.016, 0),
//                               child: TextFormField(
//                                 initialValue: "${node.data}",
//                                 cursorColor: Colors.white,
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w500),
//                                 decoration: InputDecoration(
//                                   focusedBorder: InputBorder.none,
//                                   enabledBorder: InputBorder.none,
//                                 ),
//                                 onChanged: (value) {
//                                   node.data = value;
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.add_circle_rounded,
//                               color: Color.fromRGBO(72, 236, 128, 1)),
//                           onPressed: () {
//                             print("parent_key ${node.key}");
//                             TreeNode newNode = TreeNode();
//                             node..add(newNode);
//                             print("newnode ${newNode.key}");
//                             _controller?.expandAllChildren(sampleTree);
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.delete,
//                               color: Color.fromRGBO(245, 71, 71,
//                                   1)), // Add another icon for a different action
//                           onPressed: () {
//                             node.parent!.remove(node);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// final sampleTree = TreeNode.root()..add(TreeNode(key: "0"));
