import 'package:flutter/material.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/domain/model/dto/story_response_dto.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class BookWidget extends StatelessWidget {
  final StoryResponseDto story;
  final bool isFavorite;
  final VoidCallback onFavorite;

  const BookWidget({
    super.key,
    required this.story,
    this.isFavorite = false,
    required this.onFavorite
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final labelStyle =
        textStyle.bodySmall!.copyWith(fontWeight: FontWeight.bold);
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
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Container(
                      width: double.infinity,
                      height: 140,
                      decoration: BoxDecoration(
                        image: story.cover.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(story.cover),
                            fit: BoxFit.cover,
                            onError: (exception, stackTrace) {
                              // Manejar el error aquí si es necesario
                              print('Error loading image: $exception');
                            },
                          )
                        : null,
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
                            iconColor: WidgetStateProperty.all<Color>(
                                AppColors.primaryColor),
                            backgroundColor: WidgetStateProperty.all<Color>(
                                AppColors.background)),
                        onPressed: onFavorite,
                        icon: Icon(
                          isFavorite
                            ? Icons.book
                            : Icons.book_outlined)),
                  )
                ]),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  story.title.isEmpty ? '(título)' :story.title,
                  style: textStyle.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  story.synopsis.isEmpty ? '(Sinipsis del libro)' : story.synopsis,
                  style: textStyle.labelLarge!
                      .copyWith(fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 3,
                ),
              ],
            ),
            Column(
              children: [
                const StarRating(calification: 4),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconLabelWidget(
                        iconSize: 15,
                        spaceWith: 1,
                        labelStyle: labelStyle.copyWith(fontSize: 12),
                        label: '${story.readings ?? 0} reads',
                        icon: Icons.remove_red_eye_outlined),
                    IconLabelWidget(
                        iconSize: 15,
                        spaceWith: 0,
                        labelStyle: labelStyle.copyWith(fontSize: 12),
                        label: 'a 2km',
                        icon: Icons.place_outlined)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
