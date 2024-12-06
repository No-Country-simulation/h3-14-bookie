import 'package:h3_14_bookie/domain/model/label.dart';
import 'package:h3_14_bookie/domain/services/label_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String LABEL_COLLECTION_REF = "labels";

class LabelServiceImpl implements ILabelService {
  final db = FirebaseFirestore.instance;

  late final CollectionReference _categoryRef;

  LabelServiceImpl() {
    _categoryRef = db.collection(LABEL_COLLECTION_REF).withConverter<Label>(
        fromFirestore: (snapshots, _) => Label.fromFirestore(snapshots, _),
        toFirestore: (category, _) => category.toFirestore());
  }

  @override
  Stream<QuerySnapshot<Object?>> getLabels() {
    // TODO: implement getLabels
    throw UnimplementedError();
  }

  @override
  String createLabel(String categoryName) {
    Label category = Label(name: categoryName);
    _categoryRef.add(category);

    return 'created';
  }
}
