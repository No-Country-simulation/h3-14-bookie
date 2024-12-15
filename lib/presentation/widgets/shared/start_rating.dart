import 'package:flutter/material.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';

class StarRating extends StatelessWidget {
  final double calification;
  const StarRating({super.key, required this.calification});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          height: 20,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Icon(
                index < calification ? Icons.star : Icons.star_border,
                color: const Color(0xff906E2A),
                size: 18,
              );
            },
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text('$calification')
      ],
    );
  }
}
