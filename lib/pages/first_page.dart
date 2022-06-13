import 'package:flutter/material.dart';
import 'package:qentah_app/widgets/smart_wraper.dart';

class FirstPage extends StatefulWidget {
  static const url = "/firstPage";

  const FirstPage({
    Key? key,
    this.settings,
  }) : super(key: key);
  final RouteSettings? settings;
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
            Icon(Icons.no_sim),
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
    return SingleChildScrollView(
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) => SmartWraper(
              constraints: constraints,
              children: [
                SmartItem(
                  minWidth: 300,
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Machine Type"),
                    ),
                  ),
                ),
                SmartItem(
                  minWidth: 300,
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "RPI ID"),
                    ),
                  ),
                ),
                SmartItem(
                  minWidth: 300,
                  content: Container(
                    width: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text("Search"),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) => SmartWraper(
              constraints: constraints,
              children: [
                SmartItem(
                  minWidth: 600,
                  content: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(8.0)),
                    height: 600,
                  ),
                ),
                SmartItem(
                    minWidth: 300,
                    content: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.grey,
                            ),
                            width: 200,
                            height: 200,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const Text("Machine Info"),
                          ),
                          const Text(
                              "All specification of the machine should be here"),
                        ],
                      ),
                    )),
              ],
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
      child: LayoutBuilder(
        builder: (context, constraints) => SmartWraper(
          constraints: constraints,
          children: [
            SmartItem(
              minWidth: 300,
              content: Container(
                constraints: BoxConstraints(maxWidth: 400),
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
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text("Register"),
                          )),
                    )
                  ],
                ),
              ),
            ),
            SmartItem(
                minWidth: 300,
                content: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey,
                      ),
                      width: 200,
                      height: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text("Machine Info"),
                    ),
                    const Text(
                        "All specification of the machine should be here"),
                  ],
                )),
            SmartItem(
                minWidth: 300,
                content: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text("Generated QR Code"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
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
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Download"),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
