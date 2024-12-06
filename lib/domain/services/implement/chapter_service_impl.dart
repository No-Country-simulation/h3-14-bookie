import 'package:h3_14_bookie/domain/model/chapter.dart';
import 'package:h3_14_bookie/domain/services/chapter_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String CHAPTER_COLLECTION_REF = "chapter";

class ChapterServiceImpl implements IChapterService {
  final db = FirebaseFirestore.instance;

  late final CollectionReference _chapterRef;

  ChapterServiceImpl() {
    _chapterRef = db.collection(CHAPTER_COLLECTION_REF).withConverter<Chapter>(
        fromFirestore: (snapshots, _) => Chapter.fromFirestore(snapshots, _),
        toFirestore: (category, _) => category.toFirestore());
  }

  @override
  Stream<QuerySnapshot<Object?>> getChapters() {
    // TODO: implement getChapters
    throw UnimplementedError();
  }

  @override
  String createChapter(int chapterNumber) {
    Chapter chapter = Chapter(number: chapterNumber);
    _chapterRef.add(chapter);

    return 'created';
  }
}
