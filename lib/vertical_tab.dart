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
