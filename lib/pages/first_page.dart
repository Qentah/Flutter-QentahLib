import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.pink.shade400,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              color: Colors.pink.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
