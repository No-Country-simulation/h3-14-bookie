import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h3_14_bookie/domain/model/chapter.dart';

interface class IReadingService {
  Stream<QuerySnapshot> getReadings() {
    return Stream.empty();
  }

  String createReading(String? storyId) {
    return '';
  }
}
