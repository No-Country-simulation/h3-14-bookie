import 'package:h3_14_bookie/domain/model/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  final String? title;
  final String? author; //AppUser name
  final String? cover;
  final String? synopsis;
  final List<String>? labels;
  final List<Category> categories;
  final int? rate;
  final int? readings;
  final int? storyTimeInMin;
  final bool? isDraft;
  final List<String>? chaptersUid;

  Story(
      {this.title,
      this.author,
      this.cover,
      this.synopsis,
      this.labels,
      required this.categories,
      this.rate,
      this.readings,
      this.storyTimeInMin,
      this.isDraft,
      this.chaptersUid});

  factory Story.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Story(
        title: data?['title'],
        author: data?['author'],
        cover: data?['cover'],
        synopsis: data?['synopsis'],
        labels: data?['labels'] is Iterable ? List.from(data?['labels']) : null,
        categories: data?['categories'] is Iterable
            ? List<Category>.from(data?['categories']
                .map((category) => Category(name: category['name'])))
            : [],
        rate: data?['rate'],
        readings: data?['readings'],
        storyTimeInMin: data?['storyTimeInMin'],
        isDraft: data?['isDraft'],
        chaptersUid: data?['chaptersUid'] is Iterable
            ? List.from(data?['chaptersUid'])
            : []);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
      if (author != null) "author": author,
      if (cover != null) "cover": cover,
      if (synopsis != null) "synopsis": synopsis,
      if (labels != null) "labels": labels,
      "categories": categories.map((category) => category.toFirestore()),
      if (rate != null) "rate": rate,
      if (readings != null) "readings": readings,
      if (storyTimeInMin != null) "storyTimeInMin": storyTimeInMin,
      if (isDraft != null) "isDraft": isDraft,
      if (chaptersUid != null) "chaptersUid": chaptersUid,
    };
  }
}
