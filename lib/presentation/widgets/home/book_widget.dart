import 'package:flutter/material.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class BookWidget extends StatelessWidget {
  const BookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return RepaintBoundary(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 7,
                offset: const Offset(0, 3))
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(height: 3,),
            Text('Titulo del libro', style: textStyle.bodyMedium!.copyWith(fontWeight: FontWeight.bold),),
            Text('Inicio de sinipsis del libro',
              style: textStyle.bodySmall,
              overflow: TextOverflow.ellipsis, maxLines: 2,),
            const StarRating(calification: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('10K reads a 2km'),
                GestureDetector(onTap: (){}, child: const Icon(Icons.book_outlined))
              ],
            )
          ],
        ),
      ),
    );
  }
}