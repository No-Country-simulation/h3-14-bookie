import 'package:h3_14_bookie/domain/model/Location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chapter {
  final int? number;
  final String? title;
  final String? content;
  final bool? isCompleted;
  final Location? location;

  Chapter(
      {this.number, this.title, this.content, this.isCompleted, this.location});

  factory Chapter.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Chapter(
      number: data?['number'],
      title: data?['title'],
      content: data?['content'],
      isCompleted: data?['isCompleted'],
      location: data?['location'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (number != null) "number": number,
      if (title != null) "title": title,
      if (content != null) "content": content,
      if (isCompleted != null) "isCompleted": isCompleted,
      if (location != null) "location": location,
    };
  }
}
