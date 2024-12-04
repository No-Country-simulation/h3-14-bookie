import 'package:h3_14_bookie/domain/model/chapter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Reading {
  final String? storyId;
  final List<Chapter>? completedChapter;
  final bool? inLibrary;

  Reading({this.storyId, this.completedChapter, this.inLibrary});

  factory Reading.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Reading(
      storyId: data?['storyId'],
      completedChapter: data?['completedChapter'] is Iterable
          ? List.from(data?['completedChapter'])
          : null,
      inLibrary: data?['inLibrary'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (storyId != null) "storyId": storyId,
      if (completedChapter != null) "completedChapter": completedChapter,
      if (inLibrary != null) "inLibrary": inLibrary
    };
  }
}
