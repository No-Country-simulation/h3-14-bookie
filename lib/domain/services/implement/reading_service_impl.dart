import 'package:firebase_auth/firebase_auth.dart';
import 'package:h3_14_bookie/domain/model/chapter.dart';
import 'package:h3_14_bookie/domain/model/reading.dart';
import 'package:h3_14_bookie/domain/services/app_user_service.dart';
import 'package:h3_14_bookie/domain/services/implement/app_user_service_impl.dart';
import 'package:h3_14_bookie/domain/services/reading_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReadingServiceImpl implements IReadingService {
  final db = FirebaseFirestore.instance;
  final IAppUserService appUserService = AppUserServiceImpl();

  ReadingServiceImpl();

  @override
  Future<List<Reading>> getUserReadings(bool? inLibrary) async {
    final appUser = await appUserService
        .getAppUserByAuthUserUid(FirebaseAuth.instance.currentUser?.uid ?? "");
    if (appUser == null) {
      throw Exception('AppUser not found');
    }
    if (inLibrary == null) {
      return appUser.readings ?? [];
    }
    final readings = appUser.readings;
    return readings
            ?.where((reading) => reading.inLibrary == inLibrary)
            .toList() ??
        [];
  }

  @override
  Future<bool> updateInLibrary(String storyId, bool inLibrary) async {
    final readings = await getUserReadings(null);
    if (readings.isEmpty) {
      return false;
    }

    final readingToUpdate = readings.firstWhere(
      (reading) => reading.storyId == storyId,
      orElse: () => throw Exception('Reading not found'),
    );

    final updatedReading =
        Reading(storyId: readingToUpdate.storyId, inLibrary: inLibrary);

    final readingIndex = readings.indexOf(readingToUpdate);
    readings[readingIndex] = updatedReading;

    final readingMaps = readings.map((r) => r.toFirestore()).toList();

    final appUserDoc = await db
        .collection(APP_USER_COLLECTION_REF)
        .where('authUserUid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();

    await appUserDoc.docs.first.reference.update({
      "readings": readingMaps,
    });

    return true;
  }
}
