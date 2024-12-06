import 'package:cloud_firestore/cloud_firestore.dart';

interface class IChapterService {
  Stream<QuerySnapshot> getChapters() {
    return Stream.empty();
  }

  String createChapter(int chapterNumber) {
    return '';
  }
}
