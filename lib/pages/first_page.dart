import 'dart:math';

import 'package:flutter/material.dart';
import 'package:separated_row/separated_row.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var tabController = TabController(length: 3, vsync: this);
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: TabBar(
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.grey,
          controller: tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.app_registration_rounded),
              text: "Register",
            ),
            Tab(
              icon: Icon(Icons.gas_meter_sharp),
              text: "Machines",
            ),
            Tab(
              icon: Icon(Icons.type_specimen),
              text: "Types",
            ),
          ],
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            SingleChildScrollView(
              child: ResponsiveStretchRow(
                children: [
                  RSRElement(min_width: 100, child: newMethod(50)),
                  RSRElement(min_width: 200, child: newMethod(200)),
                  RSRElement(min_width: 300, child: newMethod(400)),
                  RSRElement(min_width: 200, child: newMethod(100)),
                  RSRElement(min_width: 200, child: newMethod(100)),
                  RSRElement(min_width: 500, child: newMethod(100)),
                  RSRElement(min_width: 500, child: newMethod(100)),
                  RSRElement(min_width: 500, child: newMethod(300)),
                  RSRElement(min_width: 500, child: newMethod(500)),
                  RSRElement(min_width: 500, child: newMethod(400)),
                ],
              ),
            ),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }

  Container newMethod(double height) => Container(
        color:
            Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
        height: height,
      );
}

class RSRElement extends StatelessWidget {
  const RSRElement({Key? key, required this.min_width, required this.child})
      : super(key: key);

  final Widget child;
  final double min_width;

  @override
  Widget build(BuildContext context) => Center(
        child: child,
      );
}

class ResponsiveStretchRow extends StatelessWidget {
  ResponsiveStretchRow({Key? key, required this.children}) : super(key: key);

  final List<RSRElement> children;
  final List<double> min_sizes = [
    300,
    100,
    200,
    300,
    500,
    300,
    100,
    100,
    300,
    300,
    100,
    200,
    300,
    500,
    300,
    100,
    100,
    300,
    300,
    100,
    200,
    300,
    500,
    300,
    100,
    100,
    300,
    300,
    100,
    200,
    300,
    500,
    300,
    100,
    100,
    300
  ];

  @override
  Widget build(BuildContext context) =>
      LayoutBuilder(builder: (context, constraints) {
        List<List<Widget>> rows = [];

        var size = .0;
        List<Widget> row = [];
        for (var i = 0; i < children.length; i++) {
          if (children[i].min_width + size > constraints.maxWidth) {
            rows.add(List.from(row));
            row.clear();
            size = 0;
          }
          size += min_sizes[i];
          row.add(Expanded(
              flex: children[i].min_width.toInt(), child: children[i]));
        }
        rows.add(List.from(row));

        return Column(
          children: [
            for (var row in rows)
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: row,
                ),
              )
          ],
        );
      });
}
