import 'package:collection/collection.dart';
import 'package:qentah_app/responsive_scaffold.dart';
import 'package:qentah_app/vertical_tab.dart';
import 'package:recase/recase.dart';
import 'package:flutter/material.dart';
import 'package:qentah_app/pages/first_page.dart';

void main() {
  runApp(const QentahApp());
}

class QentahApp extends StatelessWidget {
  const QentahApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(
        title: "QentahApp",
        home: MainPage(),
      );
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController pc = PageController();
  int currentIndex = 0;

  final pages = [
    const FirstPage(),
    Container(color: Colors.red),
    Container(color: Colors.orange),
    Container(color: Colors.yellow),
    Container(color: Colors.green),
  ];

  final icons = [
    Icons.bar_chart,
    Icons.engineering_outlined,
    Icons.shopping_bag_outlined,
    Icons.qr_code_2,
    Icons.group,
  ];

  Widget _btnTab(BuildContext context, IconData icon, String text) => Container(
        width: 250,
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Icon(icon),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text),
          )
        ]),
      );

  @override
  Widget build(BuildContext context) {
    final btns = pages
        .mapIndexed((index, element) => _btnTab(context, icons[index],
            ReCase(element.runtimeType.toString()).titleCase))
        .toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        return ResponsiveDrawerScaffold(
          isCompactMode: constraints.maxWidth < 768,
          appBar: AppBar(elevation: 2),
          drawer: VerticalTabMenu(
            currentIndex: currentIndex,
            controller: pc,
            children: btns,
            skinActive: (element) => DefaultTextStyle(
              style: const TextStyle(fontWeight: FontWeight.bold),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 2, color: Theme.of(context).primaryColor)),
                  color: Theme.of(context).primaryColorLight,
                ),
                child: element,
              ),
            ),
          ),
          body: Expanded(
            child: PageView(
              controller: pc,
              onPageChanged: (index) => setState(() => currentIndex = index),
              children: pages,
            ),
          ),
        );
      },
    );
  }
}
