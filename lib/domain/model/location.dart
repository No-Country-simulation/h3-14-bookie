import 'package:cloud_firestore/cloud_firestore.dart';

class Location {
  final String? place;
  final double? lat;
  final double? long;

  Location({this.place, this.lat, this.long});

  factory Location.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Location(
      place: data?['place'],
      lat: data?['lat'],
      long: data?['long'],
    );
  }

  factory Location.fromMap(Map<String, dynamic> data) {
    return Location(
      place: data['place'],
      lat: data['lat'],
      long: data['long'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (place != null) "place": place,
      if (lat != null) "lat": lat,
      if (long != null) "long": long,
    };
  }
}
