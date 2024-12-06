import 'package:h3_14_bookie/domain/model/history.dart';
import 'package:h3_14_bookie/domain/services/story_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String STORY_COLLECTION_REF = "stories";

class StoryServiceImpl implements IStoryService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

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
  String createStory(String title) {
    Story story = Story(title: title);
    _storyRef.add(story);

    return 'created';
  }

  @override
  Future<Story?> getStoryDetailById(int storyId) {
    // TODO: implement getStoryDetailById
    throw UnimplementedError();
  }
}
