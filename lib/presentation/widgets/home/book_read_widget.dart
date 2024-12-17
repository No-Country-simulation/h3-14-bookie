import 'package:flutter/material.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/domain/model/dto/reading_response_dto.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class BookReadWidget extends StatelessWidget {
  final ReadingResponseDto reading;
  const BookReadWidget({super.key, required this.reading});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final labelStyle = textStyle.bodySmall!.copyWith(fontWeight: FontWeight.bold);
    return RepaintBoundary(
      child: Container(
        width: 180,
        height: 250,
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
                  image: DecorationImage(
                    image: NetworkImage(reading.cover!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Text(reading.title ?? '',
              overflow: TextOverflow.ellipsis, maxLines: 1,
              style: textStyle.bodyLarge!.copyWith(fontWeight: FontWeight.w700),),
            Text(reading.synopsis ?? '',
              style: textStyle.labelLarge!.copyWith(fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis, maxLines: 1,),
            const SizedBox(height: 7,),
            LinearProgressIndicator(
              value: reading.lastPageInChapterReaded!.length.toDouble(),
              color: const Color(0xFF906E2A),
              backgroundColor: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 7,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.list, size: 24, color: AppColors.primaryColor,),
                SizedBox(width: 5),
                Text(
                  '${reading.readingChaptersUids!.length} Capítulos',
                  style: TextStyle(
                    fontSize: 12,
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