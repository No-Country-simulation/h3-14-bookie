import 'package:flutter/material.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';

// ignore: must_be_immutable
class EndDrawerWidget extends StatelessWidget {

  static var instance = EndDrawerWidget();
  Widget body = Container();

  EndDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: AppColors.secondaryColor,
        child: body));
  }
}
