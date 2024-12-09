import 'package:flutter/material.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';

class CustomChipSelect extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const CustomChipSelect({super.key, required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(30.0),
            color: active ? AppColors.secondaryColor : null),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style:
                  const TextStyle(fontSize: 16.0, color: AppColors.primaryColor),
              textAlign: TextAlign.center,
            ),
            if (active) ...[
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.check,
                color: AppColors.primaryColor,
              )
            ]
          ],
        ),
      ),
    );
  }
}