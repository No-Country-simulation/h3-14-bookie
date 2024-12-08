import 'package:equatable/equatable.dart';

class BookChapterEntity extends Equatable{
  final String uid;
  final String placeName;
  final String titleChapter;
  final List<String> pages;

  const BookChapterEntity({
    required this.uid,
    required this.placeName,
    required this.titleChapter,
    required this.pages,
  });

  const BookChapterEntity.empty() 
      : this(
    uid: '',
    placeName: '',
    titleChapter: '',
    pages: const []); 

  BookChapterEntity copyWith({
    String? uid,
    String? placeName,
    String? titleChapter,
    List<String>? pages,
  }) {
    return BookChapterEntity(
      uid: uid ?? this.uid,
    placeName: placeName ?? this.placeName,
    titleChapter: titleChapter ?? this.titleChapter,
    pages: pages ?? this.pages);
  }
  
  @override
  List<Object?> get props => [uid, placeName, titleChapter, pages];
}