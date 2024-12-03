import 'package:flutter/material.dart';

class BorderLayout extends StatelessWidget {
  final Widget child;
  const BorderLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    double horizontal = 20;
    double veritical = 10;

    return Padding(
      padding: EdgeInsets.only(
        left: horizontal,
        right: horizontal,
        top: veritical
      ),
      child: child,
    );
  }
}
