import 'package:flutter/material.dart';
import 'package:h3_14_bookie/domain/model/app_user.dart';
import 'package:h3_14_bookie/domain/model/dto/category_dto.dart';
import 'package:h3_14_bookie/domain/model/dto/chapter_dto.dart';
import 'package:h3_14_bookie/domain/model/dto/story_dto.dart';
import 'package:h3_14_bookie/domain/model/dto/user_dto.dart';
import 'package:h3_14_bookie/domain/model/reading.dart';
import 'package:h3_14_bookie/domain/model/story.dart';
import 'package:h3_14_bookie/domain/model/writing.dart';
import 'package:h3_14_bookie/domain/services/app_user_service.dart';
import 'package:h3_14_bookie/domain/services/auth_service.dart';
import 'package:h3_14_bookie/domain/services/category_service.dart';
import 'package:h3_14_bookie/domain/services/chapter_service.dart';
import 'package:h3_14_bookie/domain/services/firebase_service.dart';
import 'package:h3_14_bookie/domain/services/implement/app_user_service_impl.dart';
import 'package:h3_14_bookie/domain/services/implement/category_service_impl.dart';
import 'package:h3_14_bookie/domain/services/implement/chapter_service_impl.dart';
import 'package:h3_14_bookie/domain/services/implement/story_service_impl.dart';
import 'package:h3_14_bookie/domain/services/story_service.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 100),
        const Center(
          child: Text('Favorites View'),
        ),
        const SizedBox(height: 50),
        _Button(context),
        _Button2(context),
      ],
    );
  }
}

Widget _Button(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const SizedBox(height: 16),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF006494),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: const Size(double.infinity, 56),
          elevation: 0,
        ),
        onPressed: () async {
          IChapterService chapterService = ChapterServiceImpl();
          ChapterDto chapterDto = ChapterDto(
            storyUid: 'fpoUZ07nsat0zB11ppfQ',
            title: 'Chapter 2',
            pages: [
              'lorem ipsum dolor sit amet',
              'consectetur adipiscing elit',
              'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'
            ],
            placeName: 'Place 2',
            lat: 134,
            long: 111,
          );
          final chapterUid = await chapterService.createChapter(chapterDto);
          print(chapterUid);
        },
        child: const Text(
          "crear",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}

Widget _CategoryList(List<CategoryDto> categories) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: categories.length,
    itemBuilder: (context, index) {
      final category = categories[index];
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: ListTile(
          title: Text(category.name),
          subtitle: Text('ID: ${category.uid}'),
        ),
      );
    },
  );
}

Widget _Button2(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const SizedBox(height: 16),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF006494),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: const Size(double.infinity, 56),
          elevation: 0,
        ),
        onPressed: () async {
          IStoryService storyService = StoryServiceImpl();
          IChapterService chapterService = ChapterServiceImpl();
          ICategoryService categoryService = CategoryServiceImpl();
          final categories = await categoryService.getCategories();
          print(categories);
          String categoryUid = '';
          for (var category in categories) {
            categoryUid = category.uid;
          }
          print(categoryUid);

          final storyDto = StoryDto(
              title: 'Story 1',
              cover: 'cover1.jpg',
              synopsis: 'This is a test story',
              categoriesUid: [categoryUid],
              labels: ['asdf', 'afasd']);
          final storyUid = await storyService.createStory(storyDto);
          ChapterDto chapterDto = ChapterDto(
            storyUid: storyUid,
            title: 'Chapter 1',
            pages: [
              'lorem ipsum dolor sit amet',
              'consectetur adipiscing elit'
            ],
            placeName: 'Place 1',
            lat: 123,
            long: 456,
          );
          final chapterUid = await chapterService.createChapter(chapterDto);
          print(chapterUid);
        },
        child: const Text(
          "Actualizar datos",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}
