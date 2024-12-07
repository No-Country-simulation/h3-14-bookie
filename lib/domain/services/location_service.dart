import 'package:cloud_firestore/cloud_firestore.dart';

interface class ILocationService {
  Stream<QuerySnapshot> getLocations() {
    return Stream.empty();
  }

  String createLocation(String categoryName) {
    return '';
  }
}
