import 'package:cloud_firestore/cloud_firestore.dart';

class Reading {
  final String? storyId;
  final List<String>? readingChaptersUids;
  final bool? inLibrary;
  final Map<String, int>?
      lastPageInChapterReaded; //Stores which page was the last one read in each chapter, mapped by chapterUid

  Reading(
      {this.storyId,
      this.readingChaptersUids,
      this.inLibrary,
      this.lastPageInChapterReaded});

  factory Reading.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Reading(
      storyId: data?['storyId'],
      readingChaptersUids: data?['readingChaptersUids'] is Iterable
          ? List.from(data?['readingChaptersUids'])
          : null,
      inLibrary: data?['inLibrary'],
      lastPageInChapterReaded:
          data?['lastPageInChapterReaded'] is Map<String, int>
              ? Map.from(data?['lastPageInChapterReaded'])
              : null,
    );
  }

  factory Reading.fromMap(Map<String, dynamic> data) {
    return Reading(
      storyId: data['storyId'] ?? '',
      readingChaptersUids: data['readingChaptersUids'] is Iterable
          ? List.from(data['readingChaptersUids'])
          : null,
      inLibrary: data['inLibrary'],
      lastPageInChapterReaded:
          data['lastPageInChapterReaded'] is Map<String, int>
              ? Map.from(data['lastPageInChapterReaded'])
              : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (storyId != null) "storyId": storyId,
      if (readingChaptersUids != null)
        "readingChaptersUids": readingChaptersUids,
      if (inLibrary != null) "inLibrary": inLibrary,
      if (lastPageInChapterReaded != null)
        "lastPageInChapterReaded": lastPageInChapterReaded,
    };
  }
}
