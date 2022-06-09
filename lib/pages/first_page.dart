import 'dart:math' as math;

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
              child: ResponsiveStretchRow(elemMinWidth: 200, children: [
                for (var i = 0; i < 10; ++i)
                  Container(
                    height: 100,
                    width: 100,
                    color:
                        Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(1.0),
                  ),
              ]),
            ),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}

class ResponsiveStretchRow extends StatelessWidget {
  const ResponsiveStretchRow(
      {Key? key, required this.elemMinWidth, required this.children})
      : super(key: key);

  final double elemMinWidth;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) =>
      LayoutBuilder(builder: (context, constraints) {
        List<List<Widget>> rows = [];

        final m_elem = constraints.maxWidth ~/ elemMinWidth;

        List<Widget> row = [];
        for (var i = 0; i < children.length; i++) {
          if (i != 0 && i % m_elem == 0) {
            rows.add(List.from(row));
            row.clear();
          }
          row.add(children[i]);
        }
        rows.add(List.from(row));

        return Column(
          children: [
            for (var row in rows)
              Row(
                children: [for (var elem in row) Expanded(child: elem)],
              )
          ],
        );
      });
}
