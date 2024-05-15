import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mirai/mirai.dart';
import 'package:provider/provider.dart';
import 'package:server_driven_ui/Providers/UIProvider.dart';
import 'package:server_driven_ui/UI/DynamicUI.dart';
import 'package:server_driven_ui/UI/MiraiUI.dart';

import 'package:split_view/split_view.dart';

const showSnackBar = false;
const expandChildrenOnReady = true;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Simple Animated Tree Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  TreeViewController? _controller;

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
          // controller: SplitViewController(limits: [WeightLimit(max: 0.2),WeightLimit(max: 0.8)]),
          gripSize: 1,
          viewMode: SplitViewMode.Horizontal,
          children: [
            Column(
              children: [Text("Properties")],
            ),
            TreeView.simple(
              tree: sampleTree,
              showRootNode: false,
              expansionBehavior: ExpansionBehavior.none,
              expansionIndicatorBuilder: (context, node) =>
                  NoExpansionIndicator(tree: node),
              indentation: const Indentation(style: IndentStyle.roundJoint),
              onItemTap: (item) {
                if (kDebugMode) print("Item tapped: ${item.key}");
                print("children ${item.childrenAsList}");
              },
              onTreeReady: (controller) {
                _controller = controller;
                if (expandChildrenOnReady)
                  controller.expandAllChildren(sampleTree);
              },
              builder: (context, node) => SizedBox(
                height: size.height*0.08,
                child: Card(
                  
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: TextFormField(
                            initialValue: "${node.data}",
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                            onChanged: (value) {
                              node.data = value;
                            },
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle_rounded),
                        onPressed: () {
                          print("parent_key ${node.key}");
                          TreeNode newNode = TreeNode();
                          node..add(newNode);
                          print("newnode ${newNode.key}");
                          _controller?.expandAllChildren(sampleTree);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons
                            .delete), // Add another icon for a different action
                        onPressed: () {
                          node.parent!.remove(node);
                        },
                      ),
                    ],
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

final sampleTree = TreeNode.root()..add(TreeNode(key: "0"));
