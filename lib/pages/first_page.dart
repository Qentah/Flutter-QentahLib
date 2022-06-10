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
          children: const [
            RegisterM(),
            MachinesM(),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}

class MachinesM extends StatelessWidget {
  const MachinesM({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ResponsiveStretchRow(
        children: [
          RSRElement(
            min_width: double.infinity,
            child: Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(16.0),
              width: 1000,
              height: 100,
              child: Row(
                children: [
                  Container(
                    color: Colors.red,
                    height: 100,
                    width: 100,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Machine Type"),
                  ),
                  Container(
                    color: Colors.blue,
                    height: 100,
                    width: 100,
                  ),
                ],
              ),
            ),
          ),
          RSRElement(
            min_width: 300,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(8.0)),
              height: 700,
            ),
          ),
          RSRElement(min_width: 4.0, child: Container()),
          RSRElement(
            min_width: 300,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(8.0)),
              height: 700,
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterM extends StatelessWidget {
  const RegisterM({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ResponsiveStretchRow(
        children: [
          RSRElement(
              min_width: 300,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: "Machine Type"),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "RPI ID"),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Cruible ID"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextButton(
                            onPressed: () {}, child: Text("Register")),
                      )
                    ],
                  ),
                ),
              )),
          RSRElement(
              min_width: 300,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey,
                      ),
                      width: 200,
                      height: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text("Machine Info"),
                  ),
                  const Text("All specification of the machine should be here"),
                ],
              )),
          RSRElement(
              min_width: 300,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text("Generated QR Code"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey,
                      ),
                      width: 200,
                      height: 200,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("Download"),
                  ),
                ],
              ))
        ],
      ),
    );
  }
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

  @override
  Widget build(BuildContext context) =>
      LayoutBuilder(builder: (context, constraints) {
        List<List<Widget>> rows = [];

        var size = .0;
        List<Widget> row = [];
        for (var i = 0; i < children.length; i++) {
          if (children[i].min_width == double.infinity) {
            rows.add([Expanded(child: children[i])]);
            i++;
          }
          if (children[i].min_width + size > constraints.maxWidth) {
            rows.add(List.from(row));
            row.clear();
            size = 0;
          }
          size += children[i].min_width;
          row.add(Expanded(
              flex: children[i].min_width.toInt(), child: children[i]));
        }
        rows.add(List.from(row));

        return SingleChildScrollView(
          child: Column(
            children: [
              for (var row in rows)
                Column(
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: row,
                      ),
                    ),
                  ],
                )
            ],
          ),
        );
      });
}
