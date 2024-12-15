import 'package:h3_14_bookie/domain/model/Location.dart';
import 'package:h3_14_bookie/domain/model/chapter.dart';
import 'package:h3_14_bookie/domain/model/dto/chapter_dto.dart';
import 'package:h3_14_bookie/domain/services/chapter_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h3_14_bookie/constants/collection_references.dart';

class ChapterServiceImpl implements IChapterService {
  final db = FirebaseFirestore.instance;

  late final CollectionReference _chapterRef;

  ChapterServiceImpl() {
    _chapterRef = db
        .collection(CollectionReferences.CHAPTER_COLLECTION_REF)
        .withConverter<Chapter>(
            fromFirestore: (snapshots, _) =>
                Chapter.fromFirestore(snapshots, _),
            toFirestore: (chapter, _) => chapter.toFirestore());
  }

  @override
  Future<List<Chapter>> getChapters() async {
    final docs = await _chapterRef.get();
    return docs.docs.map((doc) {
      final chapter = (doc as DocumentSnapshot<Chapter>).data();
      if (chapter == null) throw Exception('Chapter data is null');
      return chapter;
    }).toList();
  }

  @override
  Future<Chapter> getChapterById(String chapterUid) async {
    final doc = await _chapterRef.doc(chapterUid).get();
    return doc.data() as Chapter;
  }

  @override
  Future<String> getChapterUidByStoryUidAndChapterNumber(
      String storyUid, int chapterNumber) async {
    final docs = await _chapterRef
        .where('storyUid', isEqualTo: storyUid)
        .where('number', isEqualTo: chapterNumber)
        .get();
    return docs.docs.first.id;
  }

  @override
  Future<List<Chapter>> getChaptersByStoryUid(String storyUid) async {
    List<Chapter> chapters = await getChapters();
    return chapters.where((chapter) => chapter.storyUid == storyUid).toList();
  }

  @override
  Future<Chapter> getFirstChapterByStoryUid(String storyUid) async {
    List<Chapter> chapters = await getChaptersByStoryUid(storyUid);
    return chapters.firstWhere((chapter) => chapter.number == 1);
  }

  @override
  Future<List<String>> getChapterPages(String chapterUid) async {
    final chapter = await getChapterById(chapterUid);
    return chapter.pages ?? [];
  }

  @override
  Future<String> getChapterPage(String chapterUid, int pageNumber) async {
    final chapter = await getChapterById(chapterUid);
    if (chapter.pages == null || chapter.pages!.isEmpty) {
      throw Exception('Chapter pages are null or empty');
    }
    if (pageNumber < 1 || pageNumber > chapter.pages!.length) {
      throw Exception('Page number out of bounds');
    }
    return chapter.pages![pageNumber - 1];
  }

  @override
  Future<ChapterDto> convertToChapterDto(Chapter chapter) async {
    String chapterUid = await getChapterUidByStoryUidAndChapterNumber(
        chapter.storyUid, chapter.number ?? 0);
    return ChapterDto(
      storyUid: chapter.storyUid,
      chapterUid: chapterUid,
      title: chapter.title ?? '',
      pages: chapter.pages ?? [],
      placeName: chapter.location?.place ?? '',
      lat: chapter.location?.lat ?? 0.0,
      long: chapter.location?.long ?? 0.0,
    );
  }

  /// Create a chapter and add it to the story
  /// Return the chapter uid if success
  /// Return error message if failed
  @override
  Future<String> createChapter(ChapterDto chapterDto, int chapterNumber) async {
    Location location = Location(
      place: chapterDto.placeName,
      lat: chapterDto.lat,
      long: chapterDto.long,
    );
    Chapter chapter = Chapter(
      storyUid: chapterDto.storyUid,
      title: chapterDto.title,
      pages: chapterDto.pages,
      isCompleted: false,
      location: location,
      number: chapterNumber,
    );

    final docRef = await _chapterRef.add(chapter);
    final docSnap = await docRef.get() as DocumentSnapshot<Chapter>;

    return docSnap.id;
  }

  @override
  Future<bool> deleteChaptersByStoryUid(String storyUid) async {
    QuerySnapshot querySnapshot =
        await _chapterRef.where('storyUid', isEqualTo: storyUid).get();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      await _chapterRef.doc(doc.id).delete();
    }
    return true;
  }

  @override
  Future<bool> deleteChapter(String chapterUid) async {
    try {
      await _chapterRef.doc(chapterUid).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
