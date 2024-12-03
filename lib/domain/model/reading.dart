import 'package:h3_14_bookie/domain/model/chapter.dart';

class Reading {
  final String? storyId;
  final List<Chapter>? completedChapter;
  final bool? inLibrary;

  Reading({this.storyId, this.completedChapter, this.inLibrary});
}
