import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h3_14_bookie/domain/model/history.dart';

interface class IStoryService {
  Stream<QuerySnapshot> getStories() {
    return Stream.empty();
  }

  String createStory(String title) {
    return '';
  }

  Future<Story?> getStoryDetailById(int storyId) {
    return Future(() => Story());
  }
}
