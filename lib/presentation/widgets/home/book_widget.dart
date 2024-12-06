import 'package:flutter/material.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class BookWidget extends StatelessWidget {
  const BookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final labelStyle = textStyle.bodySmall!.copyWith(fontWeight: FontWeight.bold);
    return RepaintBoundary(
      child: Container(
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
            Stack(
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
                Positioned(
                  right: 3,
                  top: 0,
                  child: IconButton(
                    style: ButtonStyle(
                      iconColor: WidgetStateProperty.all<Color>(AppColors.primaryColor),
                      backgroundColor: WidgetStateProperty.all<Color>(AppColors.background)
                    ),
                    onPressed: (){},
                    icon: const Icon(Icons.book_outlined)
                  ),
                )
              ]
            ),
            const SizedBox(height: 10,),
            Text('Titulo del libro', style: textStyle.bodyLarge!.copyWith(fontWeight: FontWeight.w700),),
            Text('Inicio de sinipsis del libro mas largo super largo largo',
              style: textStyle.labelLarge!.copyWith(fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis, maxLines: 2,),
            const SizedBox(height: 3,),
            const StarRating(calification: 4),
            const SizedBox(height: 3,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconLabelWidget(
                  iconSize: 20,
                  spaceWith: 1,
                  labelStyle: labelStyle,
                  label: '10K reads', icon: Icons.remove_red_eye_outlined),
                IconLabelWidget(
                  iconSize: 20,
                  spaceWith: 0,
                  labelStyle: labelStyle,
                  label: 'a 2km', icon: Icons.place_outlined)
              ],
            )
          ],
        ),
      ),
    );
  }
}