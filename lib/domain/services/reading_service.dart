import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h3_14_bookie/domain/model/chapter.dart';
import 'package:h3_14_bookie/domain/model/reading.dart';

interface class IReadingService {
  Future<List<Reading>> getUserReadings(bool inLibrary) async {
    throw UnimplementedError();
  }
}
