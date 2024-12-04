part of graphview;

class SugiyamaEdgeRenderer extends ArrowEdgeRenderer {
  Map<Node, SugiyamaNodeData> nodeData;
  Map<Edge, SugiyamaEdgeData> edgeData;
  BendPointShape bendPointShape;
  bool addTriangleToEdge;
  SugiyamaConfiguration configuration;

  SugiyamaEdgeRenderer(this.nodeData, this.edgeData, this.bendPointShape,
      this.addTriangleToEdge, this.configuration);

  var path = Path();

  @override
  void render(Canvas canvas, Graph graph, Paint paint) {
    var levelSeparationHalf = configuration.levelSeparation / 2;
    var arrowSize = 5.0; // 箭头大小

    graph.nodes.forEach((node) {
      var children = graph.successorsOf(node);

      children.forEach((child) {
        var edge = graph.getEdgeBetween(node, child);
        var edgePaint = (edge?.paint ?? paint)..style = PaintingStyle.stroke;
        path.reset();

        // Position at the middle-top of the child
        path.moveTo((child.x + child.width / 2), child.y);
        // // Draws a line from the child's middle-top halfway up to its parent
        path.lineTo(child.x + child.width / 2, child.y - levelSeparationHalf);

        // Draws a line from the previous point to the middle of the parent's width
        path.lineTo(node.x + node.width / 2, child.y - levelSeparationHalf);
        // Position at the middle of the level separation under the parent
        path.moveTo(node.x + node.width / 2, child.y - levelSeparationHalf);
        // Draws a line up to the parent's middle-bottom
        path.lineTo(node.x + node.width / 2, node.y + node.height);

        // Draw the path
        canvas.drawPath(path, edgePaint);

        if (edge?.showArrow ?? true) {
          // Add arrow at the end of the line
          var arrowStart =
              Offset(child.x + child.width / 2, child.y - levelSeparationHalf);
          var arrowEnd = Offset(child.x + child.width / 2, child.y);
          _drawArrow(canvas, arrowStart, arrowEnd, edgePaint.color, arrowSize);
        }
      });
    });
  }

  /// 绘制箭头
  void _drawArrow(
      Canvas canvas, Offset start, Offset end, Color color, double size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // 箭头方向
    var angle = atan2(end.dy - start.dy, end.dx - start.dx);

    // 箭头的两个边点
    var arrowLeft = Offset(
      end.dx - size * cos(angle - pi / 6),
      end.dy - size * sin(angle - pi / 6),
    );
    var arrowRight = Offset(
      end.dx - size * cos(angle + pi / 6),
      end.dy - size * sin(angle + pi / 6),
    );

    // 绘制三角形
    var path = Path()
      ..moveTo(end.dx, end.dy) // 箭头顶点
      ..lineTo(arrowLeft.dx, arrowLeft.dy)
      ..lineTo(arrowRight.dx, arrowRight.dy)
      ..close();

    canvas.drawPath(path, paint);
  }

  void _drawSharpBendPointsEdge(List<Offset> bendPoints) {
    for (var i = 1; i < bendPoints.length - 1; i++) {
      path.lineTo(bendPoints[i].dx, bendPoints[i].dy);
    }
  }

  void _drawMaxCurvedBendPointsEdge(List<Offset> bendPoints) {
    for (var i = 1; i < bendPoints.length - 1; i++) {
      final nextNode = bendPoints[i];
      final afterNextNode = bendPoints[i + 1];
      final curveEndPoint = Offset((nextNode.dx + afterNextNode.dx) / 2,
          (nextNode.dy + afterNextNode.dy) / 2);
      path.quadraticBezierTo(
          nextNode.dx, nextNode.dy, curveEndPoint.dx, curveEndPoint.dy);
    }
  }

  void _drawCurvedBendPointsEdge(List<Offset> bendPoints, double curveLength) {
    for (var i = 1; i < bendPoints.length - 1; i++) {
      final previousNode = i == 1 ? null : bendPoints[i - 2];
      final currentNode = bendPoints[i - 1];
      final nextNode = bendPoints[i];
      final afterNextNode = bendPoints[i + 1];

      final arcStartPointRadians =
          atan2(nextNode.dy - currentNode.dy, nextNode.dx - currentNode.dx);
      final arcStartPoint =
          nextNode - Offset.fromDirection(arcStartPointRadians, curveLength);
      final arcEndPointRadians =
          atan2(nextNode.dy - afterNextNode.dy, nextNode.dx - afterNextNode.dx);
      final arcEndPoint =
          nextNode - Offset.fromDirection(arcEndPointRadians, curveLength);

      if (previousNode != null &&
          ((currentNode.dx == nextNode.dx && nextNode.dx == afterNextNode.dx) ||
              (currentNode.dy == nextNode.dy &&
                  nextNode.dy == afterNextNode.dy))) {
        path.lineTo(nextNode.dx, nextNode.dy);
      } else {
        path.lineTo(arcStartPoint.dx, arcStartPoint.dy);
        path.quadraticBezierTo(
            nextNode.dx, nextNode.dy, arcEndPoint.dx, arcEndPoint.dy);
      }
    }
  }
}
