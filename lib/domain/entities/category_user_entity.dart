import 'package:equatable/equatable.dart';

class CategoryUserEntity extends Equatable{
  final String uid;
  final String name;
  final bool isActive;

  const CategoryUserEntity({
    required this.uid,
    required this.name,
    required this.isActive
  });

  CategoryUserEntity copyWith({
    String? uid,
    String? name,
    bool? isActive
  }) {
    return CategoryUserEntity(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      isActive : isActive ?? this.isActive
    );
  }
  
  @override
  List<Object?> get props => [name, isActive, uid];
}