import 'package:cloud_firestore/cloud_firestore.dart';

class Reading {
  final String? storyId;
  final List<String>? chapterUids;
  final bool? inLibrary;

  Reading({this.storyId, this.chapterUids, this.inLibrary});

  factory Reading.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Reading(
      storyId: data?['storyId'],
      chapterUids: data?['chapterUids'] is Iterable
          ? List.from(data?['chapterUids'])
          : null,
      inLibrary: data?['inLibrary'],
    );
  }

  factory Reading.fromMap(Map<String, dynamic> data) {
    return Reading(
      storyId: data['storyId'] ?? '',
      chapterUids: data['chapterUids'] is Iterable
          ? List.from(data['chapterUids'])
          : null,
      inLibrary: data['inLibrary'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (storyId != null) "storyId": storyId,
      if (chapterUids != null) "chapterUids": chapterUids,
      if (inLibrary != null) "inLibrary": inLibrary
    };
  }
}
