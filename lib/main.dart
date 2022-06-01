import 'package:qentah_app/responsive_scaffold.dart';
import 'package:recase/recase.dart';
import 'package:collection/collection.dart';
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final pages = [
          const FirstPage(),
          Container(color: Colors.red),
          Container(color: Colors.orange),
          Container(color: Colors.yellow),
          Container(color: Colors.green),
          Container(color: Colors.cyan),
          Container(color: Colors.blue),
        ];

        Widget btnTab(String text) => Row(children: [Text(text)]);

        final btns = [
          for (final page in pages)
            btnTab(ReCase(page.runtimeType.toString()).titleCase)
        ];

        return ResponsiveDrawerScaffold(
          isCompactMode: constraints.maxWidth < 768,
          appBar: AppBar(elevation: 2),
          drawer: VerticalTabMenu(
              currentIndex: currentIndex, controller: pc, children: btns),
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

class VerticalTabMenu extends StatelessWidget {
  final int currentIndex;
  final PageController controller;
  final List<Widget> children;
  final Widget Function(Widget element)? skinActive;

  const VerticalTabMenu({
    Key? key,
    this.currentIndex = 0,
    required this.controller,
    required this.children,
    this.skinActive,
  }) : super(key: key);

  Widget defaultActive(Widget element) => LayoutBuilder(
        builder: (context, constraints) => Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 2, color: Theme.of(context).primaryColor))),
          child: element,
        ),
      );

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        child: Column(
          children: children
              .mapIndexed((index, element) => InkWell(
                    onTap: () => controller.animateToPage(index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn),
                    child: (index != currentIndex)
                        ? element
                        : (skinActive == null)
                            ? defaultActive(element)
                            : skinActive!(element),
                  ))
              .toList(),
        ),
      );
}
