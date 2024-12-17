import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class BookCardWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String synopsis;
  final List<String> categories;
  final double rating;
  final int reads;
  final String placeChapterName;
  final String titleChapterName;
  final int numberChapter;
  final String storyId;

  const BookCardWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.synopsis,
    required this.categories,
    required this.rating,
    required this.reads,
    required this.placeChapterName,
    required this.titleChapterName,
    required this.numberChapter,
    required this.storyId,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.9,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  width: size.width * 0.2,
                  height: size.width * 0.2,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: size.width * 0.2,
                      height: size.width * 0.2,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      synopsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    IconLabelWidget(label: placeChapterName, icon: Icons.place_outlined),
                    const SizedBox(height: 3),
                  ],
                ),
              ),
            ],
          ),
                    IconLabelWidget(
                      label: 'Capítulo $numberChapter: $titleChapterName',
                    icon: Icons.list),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: categories.map((category) {
              return Chip(
                label: Text(category, style: const TextStyle(color: AppColors.primaryColor),),
                backgroundColor:  AppColors.background,
                side: const BorderSide(
                  color: AppColors.primaryColor,
                ),
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(16), ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StarRating(calification: rating),
              Row(
                children: [
                  const Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$reads reads',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton.filled(
                    onPressed: (){
                       context.push('/home/0/book/$storyId');
                    },
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor)
                    ),
                    icon: const Icon(Icons.arrow_forward))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
