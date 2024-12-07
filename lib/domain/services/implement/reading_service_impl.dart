import 'package:h3_14_bookie/domain/model/chapter.dart';
import 'package:h3_14_bookie/domain/model/reading.dart';
import 'package:h3_14_bookie/domain/services/reading_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String READING_COLLECTION_REF = "readings";

class ReadingServiceImpl implements IReadingService {
  final db = FirebaseFirestore.instance;

  late final CollectionReference _readingRef;

  ReadingServiceImpl() {
    _readingRef = db.collection(READING_COLLECTION_REF).withConverter<Reading>(
        fromFirestore: (snapshots, _) => Reading.fromFirestore(snapshots, _),
        toFirestore: (reading, _) => reading.toFirestore());
  }

  @override
  Stream<QuerySnapshot<Object?>> getReadings() {
    return _readingRef.snapshots();
  }

  @override
  String createReading(String? storyId) {
    Reading reading = Reading(storyId: storyId);
    _readingRef.add(reading);

    return 'created';
  }
}
