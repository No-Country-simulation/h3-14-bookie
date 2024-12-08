import 'package:h3_14_bookie/domain/model/Location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chapter {
  int? number;
  final String? title;
  final List<String>? pages;
  final bool? isCompleted;
  final Location? location;

  Chapter(
      {this.number, this.title, this.pages, this.isCompleted, this.location});

  factory Chapter.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Chapter(
      number: data?['number'],
      title: data?['title'],
      pages: data?['pages'] is Iterable ? List.from(data?['pages']) : [],
      isCompleted: data?['isCompleted'],
      location: data?['location'] != null
          ? Location.fromFirestore(data?['location'], options)
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (number != null) "number": number,
      if (title != null) "title": title,
      if (pages != null) "pages": pages,
      if (isCompleted != null) "isCompleted": isCompleted,
      if (location != null) "location": location?.toFirestore(),
    };
  }
}
