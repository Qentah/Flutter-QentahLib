import 'package:collection/collection.dart';
import 'package:qentah_app/pages/login.dart';
import 'package:qentah_app/widgets/responsive_scaffold.dart';
import 'package:qentah_app/routes/router.dart';
import 'package:qentah_app/widgets/vertical_tab.dart';
import 'package:recase/recase.dart';
import 'package:flutter/material.dart';

import 'package:json_theme/json_theme.dart';

import 'package:flutter/services.dart'; // For rootBundle
import 'dart:convert'; // For jsonDecode

import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  await Supabase.initialize(
    debug: false,
    url: "https://ilkdtzewgvlrkmsauvua.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imlsa2R0emV3Z3Zscmttc2F1dnVhIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTUyOTMwODMsImV4cCI6MTk3MDg2OTA4M30.WdnlTbHugUUQ9NHAGFemRlVrrxRkhjXdvGpDfXVQtlE",
  );

  runApp(QentahApp(theme: theme));
}

class QentahApp extends StatelessWidget {
  final ThemeData theme;
  const QentahApp({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "QentahApp",
        initialRoute: "/",
        onGenerateRoute: generateRoute,
        theme: theme,
      );
}

class MainPage extends StatefulWidget {
  MainPage({Key? key, this.settings}) : super(key: key);
  final RouteSettings? settings;

  var index = 0;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final pages = [
    const LoginPage(),
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
                  .map((page) => Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              bottomLeft: Radius.circular(16.0)),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: page,
                      ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
