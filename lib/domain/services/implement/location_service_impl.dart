import 'package:h3_14_bookie/domain/model/location.dart';
import 'package:h3_14_bookie/domain/services/location_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h3_14_bookie/constants/collection_references.dart';

class LocationServiceImpl implements ILocationService {
  final db = FirebaseFirestore.instance;

  late final CollectionReference _locationRef;

  LocationServiceImpl() {
    _locationRef = db
        .collection(CollectionReferences.LOCATION_COLLECTION_REF)
        .withConverter<Location>(
            fromFirestore: (snapshots, _) =>
                Location.fromFirestore(snapshots, _),
            toFirestore: (location, _) => location.toFirestore());
  }

  @override
  Stream<QuerySnapshot<Object?>> getLocations() {
    return _locationRef.snapshots();
  }

  @override
  String createLocation(String place) {
    Location location = Location(place: place);
    _locationRef.add(location);

    return 'created';
  }
}
