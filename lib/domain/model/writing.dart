import 'package:cloud_firestore/cloud_firestore.dart';

class Writing {
  final String? storyId;
  final bool? isDraft;

  Writing({this.storyId, this.isDraft});

  factory Writing.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Writing(storyId: data?['storyId'], isDraft: data?['isDraft']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (storyId != null) "storyId": storyId,
      if (isDraft != null) "isDraft": isDraft
    };
  }
}
