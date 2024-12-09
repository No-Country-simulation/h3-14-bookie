import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h3_14_bookie/domain/model/dto/writing_dto.dart';

interface class IWritingService {
  Stream<QuerySnapshot> getWritings() {
    return Stream.empty();
  }

  Future<List<WritingDto>> getMyWritings(String? draftOrPublished) async {
    throw UnimplementedError();
  }
}
