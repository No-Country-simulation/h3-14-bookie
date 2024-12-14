import 'package:flutter/material.dart';

class AppText {
  static TextStyle? h1(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18);
  }

  static TextStyle? h2(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20);
  }

  static TextStyle? h3(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18);
  }

  static TextStyle? h4(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16);
  }

  static TextStyle? h5(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14);
  }

  static TextStyle? h6(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12);
  }
}
