import 'package:flutter/material.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';

class IconLabelWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool center;
  final TextStyle? labelStyle;
  final double? iconSize;
  final double? spaceWith;

  const IconLabelWidget({
    super.key,
    required this.label,
    required this.icon,
    this.center = false,
    this.labelStyle,
    this.iconSize,
    this.spaceWith
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: center
        ? MainAxisAlignment.center
        : MainAxisAlignment.start,
      children: [
        Icon(icon, size: iconSize, color: AppColors.primaryColor,),
        SizedBox(width: spaceWith ?? 5,),
        Text(label, style: labelStyle, maxLines: 1, overflow: TextOverflow.ellipsis,)
      ],
    );
  }
}