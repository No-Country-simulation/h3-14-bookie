import 'package:h3_14_bookie/domain/model/dto/category_dto.dart';
import 'package:h3_14_bookie/domain/model/dto/story_dto.dart';
import 'package:h3_14_bookie/domain/model/dto/story_response_dto.dart';
import 'package:h3_14_bookie/domain/model/story.dart';

interface class IStoryService {
  Future<List<Story>> getStories() async {
    return [];
  }

  Future<List<StoryResponseDto>> getStoriesWithFilter(
      String filter, CategoryDto? category) async {
    return [];
  }

  Future<List<StoryResponseDto>> getStoriesResponseByStoryUid(
      List<String> storiesUid) async {
    return [];
  }

  Future<Story?> getStoryById(String storyUid) {
    return Future(() => null);
  }

  Future<int> getStoryTotalReadings(String storyUid) {
    throw UnimplementedError();
  }

  Future<bool> isThisAReading(String storyUid) {
    throw UnimplementedError();
  }

  Future<String> createStory(StoryDto storyDto) async {
    return '';
  }

  Future<Story> updateStory(String storyUid, Story updatedStory) {
    throw UnimplementedError();
  }

  Future<bool> addChapterToStory(String storyUid, String chapterUid) async {
    return false;
  }

  Future<double> rateStory(String storyUid, int rate) async {
    throw UnimplementedError();
  }

  Future<double> getStoryRate(String storyUid) async {
    throw UnimplementedError();
  }

  Future<bool> deleteAllChaptersInStory(String storyUid) async {
    return false;
  }
}
