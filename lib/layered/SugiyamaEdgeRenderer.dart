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
        var edgePaint = (edge?.paint ?? paint)
          ..style = PaintingStyle.stroke;
        path.reset();

        // if (edge?.type != 0) {
        //   // Position at the middle-top of the child
        //   path.moveTo((child.x + child.width / 3), child.y);
        //   // Draws a line from the child's middle-top halfway up to its parent
        //   path.lineTo(
        //       child.x + child.width / 3, child.y - levelSeparationHalf + 20);
        //
        //   // Draws a line from the previous point to the middle of the parent's width
        //   path.lineTo(
        //       node.x + node.width / 2, child.y - levelSeparationHalf + 20);
        //   // Position at the middle of the level separation under the parent
        //   path.moveTo(
        //       node.x + node.width / 2, child.y - levelSeparationHalf + 20);
        //   // Draws a line up to the parent's middle-bottom
        //   path.lineTo(node.x + node.width / 2, node.y + node.height);
        // }

        if (edge?.type != 0) {
          if (child.x < node.x) {
            // Position at the middle-top of the child
            path.moveTo((child.x + child.width), child.y + child.height / 2);
            // Draws a line from the child's middle-top halfway up to its parent
            path.lineTo(
                child.x + child.width , child.y + child.height / 2);

            // Draws a line from the previous point to the middle of the parent's width
            path.lineTo(
                node.x + node.width / 2, child.y + child.height / 2);
            // Position at the middle of the level separation under the parent
            path.moveTo(
                node.x + node.width / 2, child.y + child.height / 2);
            // Draws a line up to the parent's middle-bottom
            path.lineTo(node.x + node.width / 2, node.y + node.height);
          } else if(child.x == node.x) {
            // Position at the middle-top of the child
            path.moveTo((child.x + child.width / 2), child.y);
            // Draws a line from the child's middle-top halfway up to its parent
            path.lineTo(child.x + child.width / 2, child.y - levelSeparationHalf);

            // Draws a line from the previous point to the middle of the parent's width
            path.lineTo(node.x + node.width / 2, child.y - levelSeparationHalf);
            // Position at the middle of the level separation under the parent
            path.moveTo(node.x + node.width / 2, child.y - levelSeparationHalf);
            // Draws a line up to the parent's middle-bottom
            path.lineTo(node.x + node.width / 2, node.y + node.height);
          } else {
            path.moveTo(child.x, child.y + child.height / 2);
            path.lineTo(child.x - child.width * 0.5, child.y + child.height / 2);
            path.lineTo(node.x + node.width / 2, child.y + child.height / 2);
            path.moveTo(node.x + node.width / 2, child.y + child.height / 2);
            path.lineTo(node.x + node.width / 2, node.y + node.height);
          }
        } else {
          // Position at the middle-top of the child
          path.moveTo((child.x + child.width / 2), child.y);
          // Draws a line from the child's middle-top halfway up to its parent
          path.lineTo(child.x + child.width / 2, child.y - levelSeparationHalf);

          // Draws a line from the previous point to the middle of the parent's width
          path.lineTo(node.x + node.width / 2, child.y - levelSeparationHalf);
          // Position at the middle of the level separation under the parent
          path.moveTo(node.x + node.width / 2, child.y - levelSeparationHalf);
          // Draws a line up to the parent's middle-bottom
          path.lineTo(node.x + node.width / 2, node.y + node.height);
        }

        // Draw the path
        if (edge?.dash ?? false) {
          // Draw dashed line
          edgePaint.style = PaintingStyle.stroke;
          final dashPaint = Paint()
            ..color = edgePaint.color
            ..strokeWidth = edgePaint.strokeWidth
            ..style = PaintingStyle.stroke;

          // Define dash pattern (e.g., 10 pixels on, 5 pixels off)
          const dashLength = 3.0;
          const dashSpace = 3.0;

          canvas.drawPath(
            dashPath(
              path,
              dashArray: CircularIntervalList<double>([dashLength, dashSpace]),
            ),
            dashPaint,
          );
        } else {
          // Draw solid line
          canvas.drawPath(path, edgePaint);
        }

        if (edge?.arrowTitle != null && edge?.arrowTitle != '') {
          // 在线的右边显示文字，挨近箭头的位置
          final textPainter = TextPainter(
            text: TextSpan(
              text: edge?.arrowTitle,
              style: TextStyle(
                  color: edge?.arrowTitleColor ?? edgePaint.color,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
            textDirection: TextDirection.ltr,
          )
            ..layout();

          final textX = child.x + child.width / 2 + 10; // 箭头右边 5 像素
          final textY = child.y
              // - levelSeparationHalf
              - textPainter.height - 2
          ;
          // 垂直居中

          textPainter.paint(canvas, Offset(textX, textY));
        }

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
  void _drawArrow(Canvas canvas, Offset start, Offset end, Color color,
      double size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // 箭头方向
    var angle = atan2(end.dy - start.dy, end.dx - start.dx);

    // 箭头的两个边点，size 增大一倍
    var arrowLeft = Offset(
      end.dx - 2 * size * cos(angle - pi / 6),
      end.dy - 2 * size * sin(angle - pi / 6),
    );
    var arrowRight = Offset(
      end.dx - 2 * size * cos(angle + pi / 6),
      end.dy - 2 * size * sin(angle + pi / 6),
    );

    // 绘制三角形
    var path = Path()
      ..moveTo(end.dx, end.dy) // 箭头顶点
      ..lineTo(arrowLeft.dx, arrowLeft.dy)..lineTo(arrowRight.dx, arrowRight.dy)
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
