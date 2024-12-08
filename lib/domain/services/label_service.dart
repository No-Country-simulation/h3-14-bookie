import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h3_14_bookie/domain/model/label.dart';

interface class ILabelService {
  Stream<QuerySnapshot> getLabels() {
    return Stream.empty();
  }

  Future<Label> getLabelByUid(String uid) async {
    return Future(() => Label(name: 'Default Label'));
  }

  Future<String> createLabel(String labelName) async {
    return Future(() => 'created');
  }
}
