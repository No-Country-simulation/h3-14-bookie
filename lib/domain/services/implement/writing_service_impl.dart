import 'package:firebase_auth/firebase_auth.dart';
import 'package:h3_14_bookie/domain/model/dto/chapter_dto.dart';
import 'package:h3_14_bookie/domain/model/dto/writing_dto.dart';
import 'package:h3_14_bookie/domain/model/writing.dart';
import 'package:h3_14_bookie/domain/services/app_user_service.dart';
import 'package:h3_14_bookie/domain/services/chapter_service.dart';
import 'package:h3_14_bookie/domain/services/implement/app_user_service_impl.dart';
import 'package:h3_14_bookie/domain/services/implement/chapter_service_impl.dart';
import 'package:h3_14_bookie/domain/services/implement/story_service_impl.dart';
import 'package:h3_14_bookie/domain/services/story_service.dart';
import 'package:h3_14_bookie/domain/services/writing_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String WRITING_COLLECTION_REF = "writings";

class WritingServiceImpl implements IWritingService {
  final db = FirebaseFirestore.instance;
  final IAppUserService appUserService = AppUserServiceImpl();
  final IStoryService storyService = StoryServiceImpl();
  final IChapterService chapterService = ChapterServiceImpl();

  WritingServiceImpl();

  /// Get the writings of the current user
  /// If [draftOrPublished] is null, return all writings
  /// If [draftOrPublished] is "draft", return all draft writings
  /// If [draftOrPublished] is "published", return all published writings
  @override
  Future<List<WritingDto>> getMyWritings(String? draftOrPublished) async {
    final authorUid = FirebaseAuth.instance.currentUser?.uid;
    if (authorUid == null) {
      throw Exception('User not found');
    }
    final writings = await appUserService.getAuthorWritings(authorUid);
    final filteredWritings = draftOrPublished != null
        ? draftOrPublished == "draft"
            ? writings.where((writing) => writing.isDraft == true)
            : writings.where((writing) => writing.isDraft == false)
        : writings;

    final storiesResponseDtos = await storyService.getStoriesResponseByStoryUid(
        filteredWritings.map((writing) => writing.storyId!).toList());

    final writingDtos =
        await Future.wait(storiesResponseDtos.map((story) async {
      List<ChapterDto> chapters =
          await Future.wait(story.chaptersUid.map((chapterUid) async {
        final chapter = await chapterService.getChapterById(chapterUid);
        return chapterService.convertToChapterDto(chapter);
      }));
      bool isDraft = filteredWritings
              .firstWhere((writing) => writing.storyId == story.storyUid)
              .isDraft ??
          true;
      WritingDto writingDto = WritingDto(story, chapters, isDraft);
      return writingDto;
    }));
    return writingDtos;
  }

  @override
  Future<bool> deleteAllChaptersInWriting(String storyUid) async {
    bool success = await storyService.deleteAllChaptersInStory(storyUid);
    return success;
  }
}
