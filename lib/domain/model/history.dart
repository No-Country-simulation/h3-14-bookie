import 'package:flutter/foundation.dart';
import 'package:h3_14_bookie/domain/model/chapter.dart';
import 'package:h3_14_bookie/domain/model/label.dart';

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
  final List<Chapter> chapters;

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
      required this.chapters});
}
