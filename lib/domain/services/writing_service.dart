import 'package:cloud_firestore/cloud_firestore.dart';

interface class IWritingService {
  Stream<QuerySnapshot> getWritings() {
    return Stream.empty();
  }

  String createWriting(String categoryName) {
    return '';
  }
}
