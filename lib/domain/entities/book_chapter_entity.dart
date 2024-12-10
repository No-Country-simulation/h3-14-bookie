import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookChapterEntity extends Equatable{
  final String uid;
  final int number;
  final String placeName;
  final String titleChapter;
  final List<String> pages;
  final LatLng position;

  const BookChapterEntity({
    required this.number,
    required this.uid,
    required this.placeName,
    required this.titleChapter,
    required this.pages,
    this.position = const LatLng(1, 2)
  });

  const BookChapterEntity.empty() 
      : this(
    number: 0,
    uid: '',
    placeName: '',
    titleChapter: '',
    pages: const []); 

  BookChapterEntity copyWith({
    String? uid,
    String? placeName,
    String? titleChapter,
    List<String>? pages,
    LatLng? position,
    int? number,
  }) {
    return BookChapterEntity(
      number: number ?? this.number,
      uid: uid ?? this.uid,
    placeName: placeName ?? this.placeName,
    titleChapter: titleChapter ?? this.titleChapter,
    pages: pages ?? this.pages,
    position: position ?? this.position);
  }

  @override
  String toString() {
    return 'placeName $placeName, position $position, titleChapter $titleChapter';
  }
  
  @override
  List<Object?> get props => [uid, number, placeName, titleChapter, pages, position];
}