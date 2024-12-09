import 'package:flutter/material.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class BookReadWidget extends StatelessWidget {
  const BookReadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final labelStyle = textStyle.bodySmall!.copyWith(fontWeight: FontWeight.bold);
    return RepaintBoundary(
      child: Container(
        width: 180,
        height: 290,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 5,
                offset: const Offset(0, 2))
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Text('Titulo del libro', style: textStyle.bodyLarge!.copyWith(fontWeight: FontWeight.w700),),
            Text('Inicio de sinipsis del libro mas largo super largo largo',
              style: textStyle.labelLarge!.copyWith(fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis, maxLines: 2,),
            const SizedBox(height: 7,),
            LinearProgressIndicator(
              value: 0.4,
              color: const Color(0xFF906E2A),
              backgroundColor: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 7,),
            const Row(
              children: [
                Icon(Icons.book, size: 24, color: AppColors.primaryColor,),
                SizedBox(width: 5),
                Text(
                  '13 Capítulos',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Icon(Icons.more_vert)
              ],
            ),
            // const SizedBox(height: 3,),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     IconLabelWidget(
            //       iconSize: 20,
            //       spaceWith: 1,
            //       labelStyle: labelStyle,
            //       label: '10K reads', icon: Icons.remove_red_eye_outlined),
            //     IconLabelWidget(
            //       iconSize: 20,
            //       spaceWith: 0,
            //       labelStyle: labelStyle,
            //       label: 'a 2km', icon: Icons.place_outlined)
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}