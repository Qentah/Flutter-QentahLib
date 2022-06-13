import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) => Column(
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
      );
}

class VerticalTabItem extends StatelessWidget {
  const VerticalTabItem({Key? key, required this.icon, required this.label})
      : super(key: key);

  final Widget icon;
  final Text label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        icon,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: label,
        )
      ]),
    );
  }
}
