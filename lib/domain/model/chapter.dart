import 'package:h3_14_bookie/domain/model/Location.dart';

class Chapter {
  final int? number;
  final String? title;
  final String? content;
  final bool? isCompleted;
  final Location? location;

  Chapter(
      {this.number, this.title, this.content, this.isCompleted, this.location});
}
