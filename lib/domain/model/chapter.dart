import 'package:h3_14_bookie/domain/model/Location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chapter {
  final String storyUid;
  int? number;
  final String? title;
  final List<String>? pages;
  final bool? isCompleted;
  final Location? location;

  Chapter(
      {required this.storyUid,
      this.number,
      this.title,
      this.pages,
      this.isCompleted,
      this.location});

  factory Chapter.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Chapter(
      storyUid: data?['storyUid'],
      number: data?['number'],
      title: data?['title'],
      pages: data?['pages'] is Iterable ? List.from(data?['pages']) : [],
      isCompleted: data?['isCompleted'],
      location: data?['location'] != null
          ? Location.fromMap(data?['location'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "storyUid": storyUid,
      if (number != null) "number": number,
      if (title != null) "title": title,
      if (pages != null) "pages": pages,
      if (isCompleted != null) "isCompleted": isCompleted,
      if (location != null) "location": location?.toFirestore(),
    };
  }
}
