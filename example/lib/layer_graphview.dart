import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class LayeredGraphViewPage extends StatefulWidget {
  @override
  _LayeredGraphViewPageState createState() => _LayeredGraphViewPageState();
}

class _LayeredGraphViewPageState extends State<LayeredGraphViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    _dddd();
                  });
                },
                child: Text('Refresh'))
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Wrap(
            //   children: [
            //     Container(
            //       width: 100,
            //       child: TextFormField(
            //         initialValue: builder.nodeSeparation.toString(),
            //         decoration: InputDecoration(labelText: 'Node Separation'),
            //         onChanged: (text) {
            //           builder.nodeSeparation = int.tryParse(text) ?? 100;
            //           this.setState(() {});
            //         },
            //       ),
            //     ),
            //     Container(
            //       width: 100,
            //       child: TextFormField(
            //         initialValue: builder.levelSeparation.toString(),
            //         decoration: InputDecoration(labelText: 'Level Separation'),
            //         onChanged: (text) {
            //           builder.levelSeparation = int.tryParse(text) ?? 100;
            //           this.setState(() {});
            //         },
            //       ),
            //     ),
            //     Container(
            //       width: 100,
            //       child: TextFormField(
            //         initialValue: builder.orientation.toString(),
            //         decoration: InputDecoration(labelText: 'Orientation'),
            //         onChanged: (text) {
            //           builder.orientation = int.tryParse(text) ?? 100;
            //           this.setState(() {});
            //         },
            //       ),
            //     ),
            //     Container(
            //       width: 100,
            //       child: Column(
            //         children: [
            //           Text('Alignment'),
            //           DropdownButton<CoordinateAssignment>(
            //             value: builder.coordinateAssignment,
            //             items: CoordinateAssignment.values
            //                 .map((coordinateAssignment) {
            //               return DropdownMenuItem<CoordinateAssignment>(
            //                 value: coordinateAssignment,
            //                 child: Text(coordinateAssignment.name),
            //               );
            //             }).toList(),
            //             onChanged: (value) {
            //               setState(() {
            //                 builder.coordinateAssignment = value!;
            //               });
            //             },
            //           ),
            //         ],
            //       ),
            //     ),
            //     ElevatedButton(
            //       onPressed: () {
            //         final node12 = Node.Id(r.nextInt(100));
            //         var edge =
            //             graph.getNodeAtPosition(r.nextInt(graph.nodeCount()));
            //         print(edge);
            //         graph.addEdge(edge, node12);
            //         setState(() {});
            //       },
            //       child: Text('Add'),
            //     )
            //   ],
            // ),
            Expanded(
              child: InteractiveViewer(
                  constrained: false,
                  boundaryMargin: EdgeInsets.all(100),
                  minScale: 0.01,
                  maxScale: 5.6,
                  child: graph.nodeCount() == 0
                      ? Center(child: Text('No nodes'))
                      : GraphView(
                          graph: graph,
                          algorithm: SugiyamaAlgorithm(builder),
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

  Widget rectangleWidget(int? a) {
    if (a == 1 && false) {
      final node111 = Node.Id(111);
      final node1111 = Node.Id(1111);
      final node1112 = Node.Id(1112);

      final Graph graph2 = Graph();

      SugiyamaConfiguration builder2 = SugiyamaConfiguration()
        ..bendPointShape = CurvedBendPointShape(curveLength: 6)
        ..coordinateAssignment = CoordinateAssignment.UpRight;

      graph2.addEdge(node111, node1112);
      graph2.addEdge(node111, node1111);

      builder2
        ..nodeSeparation = (100)
        ..levelSeparation = (100)
        ..orientation = SugiyamaConfiguration.ORIENTATION_TOP_BOTTOM
        ..coordinateAssignment = CoordinateAssignment.UpRight;

      return GraphView(
        graph: graph2,
        algorithm: SugiyamaAlgorithm(builder2),
        paint: Paint()
          ..color = Colors.green
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke,
        builder: (Node node) {
          // I can decide what widget should be shown here based on the id
          var a = node.key!.value as int?;
          return Text('Node ${a}');
        },
      );
    }

    return GestureDetector(
        onTap: () {
          print('tapped' + a.toString());
        },
        child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
              ],
            ),
            child: Text('Node ${a}')));
  }

  final Graph graph = Graph();

  SugiyamaConfiguration builder = SugiyamaConfiguration()
    ..bendPointShape = CurvedBendPointShape(curveLength: 6)
    ..coordinateAssignment = CoordinateAssignment.UpRight;

  @override
  void initState() {
    super.initState();
    // _dddd();
    builder
      ..nodeSeparation = (10)
      ..levelSeparation = (50)
      ..orientation = SugiyamaConfiguration.ORIENTATION_TOP_BOTTOM;
  }

  void _dddd() {
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
    final node13 = Node.Id(13);
    final node14 = Node.Id(14);
    final node15 = Node.Id(15);
    final node16 = Node.Id(16);
    final node17 = Node.Id(17);
    final node18 = Node.Id(18);
    final node19 = Node.Id(19);
    final node20 = Node.Id(20);
    final node21 = Node.Id(21);
    final node22 = Node.Id(22);
    final node23 = Node.Id(23);

    // graph.addEdge(node1, node13, paint: Paint()..color = Colors.red);
    // graph.addEdge(node1, node21);
    // graph.addEdge(node1, node4);
    // graph.addEdge(node1, node3);
    // graph.addEdge(node2, node3);
    // // graph.addEdge(node2, node20);
    // graph.addEdge(node3, node4);
    // graph.addEdge(node3, node5);
    // graph.addEdge(node3, node23);
    // graph.addEdge(node4, node6);
    // graph.addEdge(node5, node7);
    // graph.addEdge(node6, node8);
    // graph.addEdge(node6, node16);
    // graph.addEdge(node6, node23);
    // graph.addEdge(node7, node9);
    // graph.addEdge(node8, node10);
    // graph.addEdge(node8, node11);
    // graph.addEdge(node9, node12);
    // graph.addEdge(node10, node13);
    // graph.addEdge(node10, node14);
    // graph.addEdge(node10, node15);
    // graph.addEdge(node11, node15);
    // graph.addEdge(node11, node16);
    // graph.addEdge(node12, node20);
    // graph.addEdge(node13, node17);
    // graph.addEdge(node14, node17);
    // graph.addEdge(node14, node18);
    // graph.addEdge(node16, node18);
    // graph.addEdge(node16, node19);
    // graph.addEdge(node16, node20);
    // graph.addEdge(node18, node21);
    // graph.addEdge(node19, node22);
    // graph.addEdge(node21, node23);
    // graph.addEdge(node22, node23);
    // graph.addEdge(node1, node22);
    // graph.addEdge(node7, node8);
    //
    // graph.addEdge(node1, node2);
    // graph.addEdge(node2, node3);
    // graph.addEdge(node2, node4);
    // graph.addEdge(node2, node5);
    // graph.addEdge(node2, node6);
    // graph.addEdge(node7, node3);
    // graph.addEdge(node7, node4);
    // graph.addEdge(node7, node5);
    // graph.addEdge(node7, node6);

    graph.addEdge(node1, node2, paint: Paint()..color = Colors.red,dash: true);
    graph.addEdge(node2, node3, paint: Paint()..color = Colors.red,dash: true);
    graph.addEdge(node2, node5, paint: Paint()..color = Colors.red,dash: true);
    graph.addEdge(node2, node6, paint: Paint()..color = Colors.red,dash: true);
    graph.addEdge(node2, node7, paint: Paint()..color = Colors.red,dash: true);
    // graph.addEdge(node3, node4);
    // graph.addEdge(node4, node5);
    // graph.addEdge(node4, node6);
    // graph.addEdge(node4, node7);

    graph.addEdge(node3, node4, showArrow: false,dash: true);
    graph.addEdge(node5, node4, showArrow: false,dash: true);
    graph.addEdge(node6, node4, showArrow: false,dash: true);
    graph.addEdge(node7, node4, showArrow: false,dash: true);

    // builder
    //   ..nodeSeparation = (60)
    //   ..levelSeparation = (60)
    //   ..orientation = SugiyamaConfiguration.ORIENTATION_TOP_BOTTOM;
  }
}
