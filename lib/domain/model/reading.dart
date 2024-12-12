import 'package:cloud_firestore/cloud_firestore.dart';

class Reading {
  final String? storyId;
  final List<String>? readingChaptersUids;
  final bool? inLibrary;

  Reading({this.storyId, this.readingChaptersUids, this.inLibrary});

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
    );
  }

  factory Reading.fromMap(Map<String, dynamic> data) {
    return Reading(
      storyId: data['storyId'] ?? '',
      readingChaptersUids: data['readingChaptersUids'] is Iterable
          ? List.from(data['readingChaptersUids'])
          : null,
      inLibrary: data['inLibrary'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (storyId != null) "storyId": storyId,
      if (readingChaptersUids != null)
        "readingChaptersUids": readingChaptersUids,
      if (inLibrary != null) "inLibrary": inLibrary
    };
  }
}
