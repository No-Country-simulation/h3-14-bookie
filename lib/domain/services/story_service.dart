import 'package:h3_14_bookie/domain/model/dto/story_dto.dart';
import 'package:h3_14_bookie/domain/model/dto/story_response_dto.dart';
import 'package:h3_14_bookie/domain/model/story.dart';

interface class IStoryService {
  Future<List<Story>> getStories() async {
    return [];
  }

  Future<List<StoryResponseDto>> getStoriesResponseByStoryUid(
      List<String> storiesUid) async {
    return [];
  }

  Future<String> createStory(StoryDto storyDto) async {
    return '';
  }

  Future<Story?> getStoryById(String storyUid) {
    return Future(() => null);
  }

  Future<bool> addChapterToStory(String storyUid, String chapterUid) async {
    return false;
  }

  Future<bool> deleteAllChaptersInStory(String storyUid) async {
    return false;
  }
}
