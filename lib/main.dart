import 'package:collection/collection.dart';
import 'package:qentah_app/responsive_scaffold.dart';
import 'package:qentah_app/routes/router.dart';
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
        initialRoute: MainPage.url,
        onGenerateRoute: generateRoute,
      );
}

class MainPage extends StatefulWidget {
  static const url = "/main";

  MainPage({Key? key, this.settings}) : super(key: key);
  final RouteSettings? settings;

  var index = 0;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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

  @override
  initState() {
    super.initState();
    try {
      final data = widget.settings!.name;
      var index = int.parse(Uri.parse(data!).queryParameters['page'] ?? "0");
      widget.index = index;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final PageController pc = PageController(initialPage: widget.index);

    final btns = pages
        .mapIndexed((index, element) => VerticalTabItem(
            icon: Icon(icons[index]),
            label: Text(ReCase(element.runtimeType.toString()).titleCase)))
        .toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        return ResponsiveDrawerScaffold(
          drawerEdgeDragWidth: 100,
          backgroundColor: Colors.grey.shade100,
          isCompactMode: constraints.maxWidth < 768,
          appBar: AppBar(elevation: 2),
          drawer: VerticalTabMenu(
            currentIndex: widget.index,
            controller: pc,
            children: btns,
            skinActive: (element) => DefaultTextStyle(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 2, color: Theme.of(context).primaryColor)),
                ),
                child: element,
              ),
            ),
          ),
          body: Expanded(
            child: PageView(
              scrollDirection: Axis.vertical,
              controller: pc,
              onPageChanged: (index) => setState(() => widget.index = index),
              children: pages
                  .map((e) => Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              bottomLeft: Radius.circular(16.0)),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: e,
                      ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
