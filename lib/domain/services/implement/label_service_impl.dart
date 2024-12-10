import 'package:h3_14_bookie/domain/model/label.dart';
import 'package:h3_14_bookie/domain/services/label_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String LABEL_COLLECTION_REF = "labels";

class LabelServiceImpl implements ILabelService {
  final db = FirebaseFirestore.instance;

  late final CollectionReference _labelRef;

  LabelServiceImpl() {
    _labelRef = db.collection(LABEL_COLLECTION_REF).withConverter<Label>(
        fromFirestore: (snapshots, _) => Label.fromFirestore(snapshots, _),
        toFirestore: (label, _) => label.toFirestore());
  }

  @override
  Stream<QuerySnapshot<Object?>> getLabels() {
    // TODO: implement getLabels
    throw UnimplementedError();
  }

  @override
  Future<Label> getLabelByUid(String uid) async {
    final docSnap = await _labelRef.doc(uid).get() as DocumentSnapshot<Label>;
    return docSnap.data()!;
  }

  @override
  Future<String> createLabel(String labelName) async {
    Label label = Label(name: labelName);
    final docRef = await _labelRef.add(label);
    final docSnap = await docRef.get() as DocumentSnapshot<Label>;
    return docSnap.id;
  }
}
