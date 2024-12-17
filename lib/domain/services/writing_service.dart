import 'package:h3_14_bookie/domain/model/dto/writing_dto.dart';

interface class IWritingService {
  Future<List<WritingDto>> getMyWritings(String? draftOrPublished) async {
    throw UnimplementedError();
  }

  Future<bool> deleteAllChaptersInWriting(String storyUid) async {
    return false;
  }
}
