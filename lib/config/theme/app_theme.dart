import 'package:flutter/material.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: AppColors.primaryColor,
        drawerTheme: const DrawerThemeData(
          backgroundColor: AppColors.secondaryColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
            foregroundColor: WidgetStateProperty.all(AppColors.accentColor),
            textStyle: WidgetStateProperty.all(
              const TextStyle(
                color: AppColors.accentColor,
              ),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(AppColors.primaryColor),
          )
        )
      );
}
