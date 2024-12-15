import 'package:firebase_auth/firebase_auth.dart';
import 'package:h3_14_bookie/domain/model/category.dart';
import 'package:h3_14_bookie/domain/model/dto/category_dto.dart';
import 'package:h3_14_bookie/domain/model/dto/story_dto.dart';
import 'package:h3_14_bookie/domain/model/dto/story_response_dto.dart';
import 'package:h3_14_bookie/domain/model/story.dart';
import 'package:h3_14_bookie/domain/services/app_user_service.dart';
import 'package:h3_14_bookie/domain/services/category_service.dart';
import 'package:h3_14_bookie/domain/services/implement/app_user_service_impl.dart';
import 'package:h3_14_bookie/domain/services/implement/category_service_impl.dart';
import 'package:h3_14_bookie/domain/services/implement/label_service_impl.dart';
import 'package:h3_14_bookie/domain/services/label_service.dart';
import 'package:h3_14_bookie/domain/services/story_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String STORY_COLLECTION_REF = "stories";
const String CHAPTER_COLLECTION_REF = "chapters";

class StoryServiceImpl implements IStoryService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final ICategoryService categoryService = CategoryServiceImpl();
  final ILabelService labelService = LabelServiceImpl();
  final IAppUserService appUserService = AppUserServiceImpl();
  late final CollectionReference _storyRef;
  late final CollectionReference _chapterRef;

  StoryServiceImpl() {
    _storyRef = db.collection(STORY_COLLECTION_REF).withConverter<Story>(
        fromFirestore: (snapshots, _) => Story.fromFirestore(snapshots, _),
        toFirestore: (story, _) => story.toFirestore());

    _chapterRef = db.collection(CHAPTER_COLLECTION_REF);
  }

  @override
  Future<List<Story>> getStories() async {
    final docs = await _storyRef.get();
    return docs.docs.map((doc) => doc.data() as Story).toList();
  }

  @override
  Future<List<String>> getAllStoriesUid() async {
    final docs = await _storyRef.get();
    return docs.docs.map((doc) => doc.id).toList();
  }

  @override
  Future<List<StoryResponseDto>> getStoriesWithFilter(
      String filter, CategoryDto? category) async {
    // Obtener las historias filtradas como antes
    var stories = await getStories();
    if (category != null) {
      stories = stories
          .where(
              (story) => story.categories!.any((c) => c.name == category.name))
          .toList();
    }

    stories = stories.where((story) {
      final containsInTitle =
          story.title?.toLowerCase().contains(filter.toLowerCase()) ?? false;
      final containsInLabels = story.labels?.any(
              (label) => label.toLowerCase().contains(filter.toLowerCase())) ??
          false;
      return containsInTitle || containsInLabels;
    }).toList();

    // Convertir las historias filtradas a StoryResponseDto
    final storiesResponseDtos = await Future.wait(
      stories.map((story) async {
        final docRef =
            _storyRef.where('title', isEqualTo: story.title).limit(1);
        final querySnapshot = await docRef.get();
        final storyUid = querySnapshot.docs.first.id;
        return await convertToStoryResponseDto(storyUid, story);
      }),
    );

    return storiesResponseDtos;
  }
  // Future<List<Story>> getStoriesWithFilter(
  //     String filter, CategoryDto? category) async {
  //   var stories = await getStories();
  //   if (category != null) {
  //     stories = stories
  //         .where(
  //             (story) => story.categories.any((c) => c.name == category.name))
  //         .toList();
  //   }

  //   return stories.where((story) {
  //     final containsInTitle =
  //         story.title?.toLowerCase().contains(filter.toLowerCase()) ?? false;
  //     final containsInLabels = story.labels?.any(
  //             (label) => label.toLowerCase().contains(filter.toLowerCase())) ??
  //         false;
  //     return containsInTitle || containsInLabels;
  //   }).toList();
  // }

  @override
  Future<List<StoryResponseDto>> getStoriesResponseByStoryUid(
      List<String> storiesUid) async {
    final storiesResponseDtos =
        await Future.wait(storiesUid.map((storyUid) async {
      final story = await getStoryById(storyUid);
      if (story == null) {
        throw Exception('Story not found');
      }
      return convertToStoryResponseDto(storyUid, story);
    }).toList());
    return storiesResponseDtos;
  }

  Future<StoryResponseDto> convertToStoryResponseDto(
      String storyUid, Story story) async {
    List<String> categoriesUid = await Future.wait(story.categories?.map(
            (category) =>
                categoryService.getCategoryUidByName(category.name ?? '')) ??
        []);

    StoryResponseDto storyResponseDto = StoryResponseDto(
        storyUid,
        story.title ?? '',
        (await appUserService.getAppUserById(story.authorUid ?? ''))?.name ??
            '',
        story.cover ?? '',
        story.synopsis ?? '',
        story.labels?.whereType<String>().toList() ?? [],
        categoriesUid,
        story.rate ?? 5.0,
        story.totalReadings ?? 0,
        story.storyTimeInMin ?? 0,
        story.chaptersUid?.toList() ?? []);
    return storyResponseDto;
  }

  @override
  Future<Story?> getStoryById(String storyUid) async {
    final docSnap = await _storyRef.doc(storyUid).get();
    if (!docSnap.exists) {
      throw Exception('Story not found');
    }
    return (docSnap as DocumentSnapshot<Story>).data();
  }

  @override
  Future<String> createStory(StoryDto storyDto) async {
    final List<Category> categories = await Future.wait(storyDto.categoriesUid
        .map((uid) => categoryService.getCategoryByUid(uid)));

    Story story = Story(
        title: storyDto.title,
        authorUid: FirebaseAuth.instance.currentUser?.uid,
        cover: storyDto.cover,
        synopsis: storyDto.synopsis,
        categories: categories,
        labels: storyDto.labels,
        rate: 5.0,
        totalReadings: 0);

    final docRef = await _storyRef.add(story);
    final docSnap = await docRef.get();
    await appUserService.addNewWriting(story.authorUid!, docSnap.id, true);

    return docSnap.id;
  }

  @override
  Future<int> getStoryTotalReadings(String storyUid) async {
    final story = await getStoryById(storyUid);
    return story?.totalReadings ?? 0;
  }

  @override
  Future<bool> isThisAReading(String storyUid) async {
    final appUserUid = FirebaseAuth.instance.currentUser?.uid;
    if (appUserUid == null) {
      return false;
    }
    final appUser = await appUserService.getAppUserByAuthUserUid(appUserUid);
    final readings = appUser?.readings ?? [];
    return readings.any((reading) => reading.storyId == storyUid);
  }

  @override
  Future<Story> updateStory(String storyUid, Story updatedStory) async {
    await _storyRef.doc(storyUid).update(updatedStory.toFirestore());
    return updatedStory;
  }

  /// Add a chapter to the story
  /// Return true if success
  /// Return false if failed
  @override
  Future<bool> addChapterToStory(String storyUid, String chapterUid) async {
    Story? story = await getStoryById(storyUid);
    if (story == null) {
      return false;
    }

    story.chaptersUid?.add(chapterUid);
    await _storyRef.doc(storyUid).update(story.toFirestore());
    return true;
  }

  /// Rate a story
  /// Add the rate to the story by averaging the old rate and the new rate
  /// Return the new rate of the story
  /// Return -1 if the story is not found
  @override
  Future<double> rateStory(String storyUid, int rate) async {
    final story = await getStoryById(storyUid);
    if (story == null) {
      return -1;
    }
    final updatedStory = Story(rate: (story.rate ?? 5.0 + rate) / 2);
    await _storyRef.doc(storyUid).update(updatedStory.toFirestore());
    return updatedStory.rate ?? -1;
  }

  @override
  Future<double> getStoryRate(String storyUid) async {
    final story = await getStoryById(storyUid);
    return story?.rate ?? -1;
  }

  @override
  Future<bool> deleteAllChaptersInStory(String storyUid) async {
    Story? story = await getStoryById(storyUid);
    if (story == null) {
      return false;
    }
    QuerySnapshot querySnapshot =
        await _chapterRef.where('storyUid', isEqualTo: storyUid).get();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      await _chapterRef.doc(doc.id).delete();
    }
    story.chaptersUid?.clear();
    await _storyRef.doc(storyUid).update(story.toFirestore());
    return true;
  }

  @override
  Future<bool> deleteStory(String storyUid) async {
    try {
      // 1. Eliminar referencias en usuarios
      final users = await appUserService.getAppUsers();
      for (var user in users) {
        await appUserService.deleteUserReading(user.authUserUid!, storyUid);
        await appUserService.deleteUserWriting(user.authUserUid!, storyUid);
      }

      // 2. Eliminar chapters relacionados
      await deleteAllChaptersInStory(storyUid);

      // 3. Eliminar la story
      await _storyRef.doc(storyUid).delete();

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
