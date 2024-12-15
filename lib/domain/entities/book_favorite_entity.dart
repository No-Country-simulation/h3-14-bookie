import 'package:equatable/equatable.dart';
import 'package:h3_14_bookie/domain/model/reading.dart';

class BookFavoriteEntity extends Equatable{
  final Reading reading;
  final bool isFavorite;
  const BookFavoriteEntity({
    required this.reading,
    this.isFavorite = false,
  });
  
  @override
  List<Object?> get props => [reading, isFavorite];
  
}