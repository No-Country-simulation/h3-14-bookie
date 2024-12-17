import 'package:h3_14_bookie/domain/model/dto/category_dto.dart';
import 'package:h3_14_bookie/domain/model/dto/chapter_dto.dart';
import 'package:h3_14_bookie/domain/model/dto/chapter_story_response_dto.dart';
import 'package:h3_14_bookie/domain/model/dto/home_story_dto.dart';
import 'package:h3_14_bookie/domain/model/dto/story_dto.dart';
import 'package:h3_14_bookie/domain/model/dto/story_response_dto.dart';
import 'package:h3_14_bookie/domain/model/story.dart';

interface class IStoryService {
  Future<List<Story>> getStories() async {
    return [];
  }

  Future<List<String>> getAllStoriesUid() async {
    throw UnimplementedError();
  }

  Future<List<StoryResponseDto>> getStoriesWithFilter(
      String filter, CategoryDto? category) async {
    return [];
  }

  Future<List<StoryResponseDto>> getStoriesResponseByStoryUid(
      List<String> storiesUid, bool? inLibrary) async {
    return [];
  }

  Future<Story?> getStoryById(String storyUid) {
    return Future(() => null);
  }

  Future<int> getStoryTotalReadings(String storyUid) {
    throw UnimplementedError();
  }

  Future<List<Story>> getPublishedStories() {
    throw UnimplementedError();
  }

  Future<HomeStoryDto> getHomeStoryDtoByStoryUid(String storyUid) {
    throw UnimplementedError();
  }

  Future<bool> isThisAReading(String storyUid) {
    throw UnimplementedError();
  }

  Future<List<ChapterStoryResponseDto>> getChaptersStory(
      String storyUid, int chapterNumber) async {
    throw UnimplementedError();
  }

  Future<List<ChapterStoryResponseDto>> getAllFirstChaptersStory() async {
    throw UnimplementedError();
  }

  Future<String> createStory(StoryDto storyDto) async {
    return '';
  }

  Future<String> addNewChapterToStory(ChapterDto chapterDto) async {
    throw UnimplementedError();
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

  Future<bool> deleteStory(String storyUid) async {
    throw UnimplementedError();
  }
}
