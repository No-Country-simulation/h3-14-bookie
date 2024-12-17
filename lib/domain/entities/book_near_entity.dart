import 'package:equatable/equatable.dart';
import 'package:h3_14_bookie/domain/model/dto/story_response_dto.dart';

class BookNearEntity extends Equatable{
  final StoryResponseDto story;
  final bool isFavorite;
  const BookNearEntity({
    required this.story,
    this.isFavorite = false
  });
  
  @override
  List<Object?> get props =>[story, isFavorite];
}