import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class TreeViewPage extends StatefulWidget {
  @override
  _TreeViewPageState createState() => _TreeViewPageState();
}

class _TreeViewPageState extends State<TreeViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Wrap(
              children: [
                Container(
                  width: 100,
                  child: TextFormField(
                    initialValue: builder.siblingSeparation.toString(),
                    decoration:
                        InputDecoration(labelText: 'Sibling Separation'),
                    onChanged: (text) {
                      builder.siblingSeparation = int.tryParse(text) ?? 100;
                      this.setState(() {});
                    },
                  ),
                ),
                Container(
                  width: 100,
                  child: TextFormField(
                    initialValue: builder.levelSeparation.toString(),
                    decoration: InputDecoration(labelText: 'Level Separation'),
                    onChanged: (text) {
                      builder.levelSeparation = int.tryParse(text) ?? 100;
                      this.setState(() {});
                    },
                  ),
                ),
                Container(
                  width: 100,
                  child: TextFormField(
                    initialValue: builder.subtreeSeparation.toString(),
                    decoration:
                        InputDecoration(labelText: 'Subtree separation'),
                    onChanged: (text) {
                      builder.subtreeSeparation = int.tryParse(text) ?? 100;
                      this.setState(() {});
                    },
                  ),
                ),
                Container(
                  width: 100,
                  child: TextFormField(
                    initialValue: builder.orientation.toString(),
                    decoration: InputDecoration(labelText: 'Orientation'),
                    onChanged: (text) {
                      builder.orientation = int.tryParse(text) ?? 100;
                      this.setState(() {});
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final node12 = Node.Id(r.nextInt(100));
                    var edge =
                        graph.getNodeAtPosition(r.nextInt(graph.nodeCount()));
                    print(edge);
                    graph.addEdge(edge, node12,dash: true);
                    setState(() {});
                  },
                  child: Text('Add'),
                )
              ],
            ),
            Expanded(
              child: InteractiveViewer(
                  constrained: false,
                  boundaryMargin: EdgeInsets.all(100),
                  minScale: 0.01,
                  maxScale: 5.6,
                  child: GraphView(
                    graph: graph,
                    algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
                    paint: Paint()
                      ..color = Colors.green
                      ..strokeWidth = 1
                      ..style = PaintingStyle.stroke,
                    builder: (Node node) {
                      // I can decide what widget should be shown here based on the id
                      var a = node.key!.value as int?;
                      return rectangleWidget(a);
                    },
                  )),
            ),
          ],
        ));
  }

  Random r = Random();

  Widget rectangleWidget(dynamic a) {

    if (a == 1 && false) {


      final node111 = Node.Id(111);
      final node112 = Node.Id(112);
      final node113 = Node.Id(113);
      graph2.addEdge(node111, node112);
      graph2.addEdge(node111, node113);


      builder2
        ..siblingSeparation = (100)
        ..levelSeparation = (150)
        ..subtreeSeparation = (150)
        ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);

      return GraphView(
        graph: graph2,
        algorithm: BuchheimWalkerAlgorithm(
            builder2, TreeEdgeRenderer(builder)),
        paint: Paint()
          ..color = Colors.green
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke,
        builder: (Node node) {
          // I can decide what widget should be shown here based on the id
          var a = node.key!.value;
          return Text('data${a}');
        },
      );
    }


    return InkWell(
      onTap: () {
        print('clicked${a}');
      },
      child: Container(
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
                  ],
                ),
                child: Text('Node ${a}')),
            Positioned(child: Text('data')),

          ],
        ),
      ),
    );
  }

  final Graph graph = Graph()/*..isTree = true*/;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  final Graph graph2 = Graph()/*..isTree = true*/;
  BuchheimWalkerConfiguration builder2 = BuchheimWalkerConfiguration();

  @override
  void initState() {
    final node1 = Node.Id(1);
    final node2 = Node.Id(2);
    final node3 = Node.Id(3);
    final node4 = Node.Id(4);
    final node5 = Node.Id(5);
    final node6 = Node.Id(6);
    final node8 = Node.Id(7);
    final node7 = Node.Id(8);
    final node9 = Node.Id(9);
    final node10 = Node.Id(10);
    final node11 = Node.Id(11);
    final node12 = Node.Id(12);
    graph.addEdge(node1, node2, paint: Paint()..color = Colors.orange);
    graph.addEdge(node2, node3, paint: Paint()..color = Colors.orange);
    graph.addEdge(node2, node5, paint: Paint()..color = Colors.orange);
    graph.addEdge(node2, node6, paint: Paint()..color = Colors.orange);
    graph.addEdge(node2, node7, paint: Paint()..color = Colors.orange);
    // graph.addEdge(node3, node4);
    // graph.addEdge(node4, node5);
    // graph.addEdge(node4, node6);
    // graph.addEdge(node4, node7);






    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);


  }
}
