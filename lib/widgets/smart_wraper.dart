import 'package:flutter/material.dart';

class SmartItem extends StatelessWidget {
  const SmartItem(
      {Key? key, required this.content, this.minWidth = double.infinity})
      : super(key: key);
  final Widget content;
  final double minWidth;
  @override
  Widget build(BuildContext context) {
    return content;
  }
}

class SmartWraper extends StatelessWidget {
  const SmartWraper({
    Key? key,
    required this.constraints,
    required this.children,
  }) : super(key: key);
  final BoxConstraints constraints;
  final List<SmartItem> children;
  @override
  Widget build(BuildContext context) {
    List<List<SmartItem>> dataCol = [];
    List<SmartItem> dataRow = [];

    for (var child in children) {
      if (child.minWidth >= double.infinity) {
        dataCol.add(List.from(dataRow));
        dataRow.clear();
        dataCol.add([SmartItem(content: child.content)]);
        continue;
      }
      if (dataRow.isNotEmpty) {
        final width = dataRow.map((e) => e.minWidth).reduce((v, e) => v + e);
        if (child.minWidth + width >= constraints.maxWidth) {
          dataCol.add(List.from(dataRow));
          dataRow.clear();
        }
      }
      dataRow.add(SmartItem(minWidth: child.minWidth, content: child.content));
    }
    dataCol
      ..add(dataRow)
      ..removeWhere(
        (row) => row.isEmpty,
      );

    return SingleChildScrollView(
      child: Column(
        children: [
          for (var row in dataCol)
            IntrinsicHeight(
              child: Row(
                children: [
                  for (var elem in row)
                    Expanded(
                        flex: elem.minWidth == double.infinity
                            ? 1
                            : elem.minWidth.toInt(),
                        child: Center(child: elem.content))
                ],
              ),
            )
        ],
      ),
    );
  }
}
