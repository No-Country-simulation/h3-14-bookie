import 'package:h3_14_bookie/domain/model/chapter.dart';
import 'package:h3_14_bookie/domain/model/writing.dart';
import 'package:h3_14_bookie/domain/services/writing_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String WRITING_COLLECTION_REF = "writings";

class WritingServiceImpl implements IWritingService {
  final db = FirebaseFirestore.instance;

  late final CollectionReference _writingRef;

  WritingServiceImpl() {
    _writingRef = db.collection(WRITING_COLLECTION_REF).withConverter<Writing>(
        fromFirestore: (snapshots, _) => Writing.fromFirestore(snapshots, _),
        toFirestore: (writing, _) => writing.toFirestore());
  }

  @override
  Stream<QuerySnapshot<Object?>> getWritings() {
    return _writingRef.snapshots();
  }

  @override
  String createWriting(String? storyId) {
    Writing writing = Writing(storyId: storyId);
    _writingRef.add(writing);

    return 'created';
  }
}
