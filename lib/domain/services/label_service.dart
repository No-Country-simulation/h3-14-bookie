import 'package:cloud_firestore/cloud_firestore.dart';

interface class ILabelService {
  Stream<QuerySnapshot> getLabels() {
    return Stream.empty();
  }

  String createLabel(String labelName) {
    return '';
  }
}
