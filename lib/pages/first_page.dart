import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qentah_app/widgets/smart_wraper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FirstPage extends StatefulWidget {
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
                      decoration:
                          const InputDecoration(labelText: "Machine Type"),
                    ),
                  ),
                ),
                SmartItem(
                  minWidth: 300,
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: "RPI ID"),
                    ),
                  ),
                ),
                SmartItem(
                  minWidth: 300,
                  content: SizedBox(
                    width: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
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
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Machine Info"),
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
                constraints: const BoxConstraints(maxWidth: 400),
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "Machine Type"),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "RPI ID"),
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "Cruible ID"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();

                            if (result != null && result.count > 0) {
                              Supabase.instance.client.storage
                                  .from("images")
                                  .uploadBinary(
                                      "me/${DateTime.now().hashCode}.${result.files[0].extension ?? ""}"
                                          .toLowerCase(),
                                      result.files[0].bytes!)
                                  .then((value) {
                                print(value.error);
                                return showDialog(
                                    context: context,
                                    builder: (_) => value.hasError
                                        ? Center(child: const Text("Error"))
                                        : Image.network(
                                            "${Supabase.instance.client.storageUrl}/object/public/${value.data!}"));
                              });
                            } else {
                              // User canceled the picker
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Pick File"),
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
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Machine Info"),
                    ),
                    const Text(
                        "All specification of the machine should be here"),
                  ],
                )),
            SmartItem(
                minWidth: 300,
                content: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Generated QR Code"),
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
                    ElevatedButton(
                      onPressed: () {
                        Supabase.instance.client.auth
                            .signIn(email: "henryq.pro@outlook.fr")
                            .then(
                          (value) {
                            print(value.url);
                            Supabase.instance.client
                                .from('profiles')
                                .select('*')
                                .execute()
                                .then((value) => print(value.data));
                          },
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
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
