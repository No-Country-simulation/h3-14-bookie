import 'package:flutter/foundation.dart';
import 'package:h3_14_bookie/domain/model/chapter.dart';
import 'package:h3_14_bookie/domain/model/label.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  final String? title;
  final String? author; //AppUser name
  final String? cover;
  final String? synopsis;
  final List<Label>? labels;
  final List<Category>? categories;
  final int? rate;
  final int? readings;
  final int? storyTimeInMin;
  final List<Chapter>? chapters;

  Story(
      {this.title,
      this.author,
      this.cover,
      this.synopsis,
      this.labels,
      this.categories,
      this.rate,
      this.readings,
      this.storyTimeInMin,
      this.chapters});

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
            ? List.from(data?['categories'])
            : null,
        rate: data?['rate'],
        readings: data?['readings'],
        storyTimeInMin: data?['storyTimeInMin'],
        chapters: data?['chapters'] is Iterable
            ? List.from(data?['chapters'])
            : null);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
      if (author != null) "author": author,
      if (cover != null) "cover": cover,
      if (synopsis != null) "synopsis": synopsis,
      if (labels != null) "labels": labels,
      if (categories != null) "categories": categories,
      if (rate != null) "rate": rate,
      if (readings != null) "readings": readings,
      if (storyTimeInMin != null) "storyTimeInMin": storyTimeInMin,
      if (chapters != null) "chapters": chapters,
    };
  }
}
