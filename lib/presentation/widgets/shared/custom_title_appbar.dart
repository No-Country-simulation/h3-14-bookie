import 'package:flutter/material.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';

class CustomTitleAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomTitleAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500);
    return AppBar(
        title: Text(title, style: textStyle,),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: AppColors.primaryColor,
              height: 1.0,
            )),
        shadowColor: AppColors.primaryColor,
        surfaceTintColor: Colors.transparent,
      );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}