import 'package:flutter/material.dart';

class IconLabelWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool center;

  const IconLabelWidget({super.key, required this.label, required this.icon, this.center = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: center
        ? MainAxisAlignment.center
        : MainAxisAlignment.start,
      children: [
        Icon(icon),
        const SizedBox(width: 5,),
        Text(label)
      ],
    );
  }
}