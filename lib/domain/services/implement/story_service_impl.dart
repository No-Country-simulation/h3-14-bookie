import 'package:firebase_auth/firebase_auth.dart';
import 'package:h3_14_bookie/domain/model/category.dart';
import 'package:h3_14_bookie/domain/model/chapter.dart';
import 'package:h3_14_bookie/domain/model/dto/story_dto.dart';
import 'package:h3_14_bookie/domain/model/story.dart';
import 'package:h3_14_bookie/domain/services/category_service.dart';
import 'package:h3_14_bookie/domain/services/implement/category_service_impl.dart';
import 'package:h3_14_bookie/domain/services/implement/label_service_impl.dart';
import 'package:h3_14_bookie/domain/services/label_service.dart';
import 'package:h3_14_bookie/domain/services/story_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String STORY_COLLECTION_REF = "stories";

class StoryServiceImpl implements IStoryService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final ICategoryService categoryService = CategoryServiceImpl();
  final ILabelService labelService = LabelServiceImpl();

  late final CollectionReference _storyRef;

  StoryServiceImpl() {
    _storyRef = db.collection(STORY_COLLECTION_REF).withConverter<Story>(
        fromFirestore: (snapshots, _) => Story.fromFirestore(snapshots, _),
        toFirestore: (story, _) => story.toFirestore());
  }

  @override
  Stream<QuerySnapshot<Object?>> getStories() {
    return _storyRef.snapshots();
  }

  @override
  Future<String> createStory(StoryDto storyDto) async {
    final List<Category> categories = await Future.wait(storyDto.categoriesUid
        .map((uid) => categoryService.getCategoryByUid(uid)));

    Story story = Story(
        title: storyDto.title,
        author: FirebaseAuth.instance.currentUser?.displayName,
        cover: storyDto.cover,
        synopsis: storyDto.synopsis,
        categories: categories,
        labels: storyDto.labels,
        isDraft: true,
        rate: 0,
        readings: 0);
    await _storyRef.add(story);

    final docRef = await _storyRef.add(story);
    final docSnap = await docRef.get();
    return docSnap.id;
  }

  @override
  Future<Story?> getStoryById(String storyUid) async {
    final docSnap = await _storyRef.doc(storyUid).get();
    if (!docSnap.exists) {
      throw Exception('Story not found');
    }
    return (docSnap as DocumentSnapshot<Story>).data();
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
}
