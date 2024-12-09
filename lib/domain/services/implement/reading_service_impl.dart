import 'package:firebase_auth/firebase_auth.dart';
import 'package:h3_14_bookie/domain/model/chapter.dart';
import 'package:h3_14_bookie/domain/model/reading.dart';
import 'package:h3_14_bookie/domain/services/app_user_service.dart';
import 'package:h3_14_bookie/domain/services/implement/app_user_service_impl.dart';
import 'package:h3_14_bookie/domain/services/reading_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String READING_COLLECTION_REF = "readings";

class ReadingServiceImpl implements IReadingService {
  final db = FirebaseFirestore.instance;
  final IAppUserService appUserService = AppUserServiceImpl();

  ReadingServiceImpl();

  @override
  Future<List<Reading>> getUserReadings(bool inLibrary) async {
    final appUser = await appUserService
        .getAppUserByAuthUserUid(FirebaseAuth.instance.currentUser?.uid ?? "");
    if (appUser == null) {
      throw Exception('AppUser not found');
    }
    final readings = appUser.readings;
    return readings
            ?.where((reading) => reading.inLibrary == inLibrary)
            .toList() ??
        [];
  }
}
