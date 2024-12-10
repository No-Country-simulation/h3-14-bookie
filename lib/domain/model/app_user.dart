import 'package:h3_14_bookie/domain/model/reading.dart';
import 'package:h3_14_bookie/domain/model/writing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String? authUserUid;
  final String? name;
  final String? email;
  final List<Reading>? readings;
  final List<Writing>? writings;

  AppUser(
      {this.authUserUid, this.name, this.email, this.readings, this.writings});

  factory AppUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return AppUser(
      authUserUid: data?['authUserUid'],
      name: data?['name'],
      email: data?['email'],
      readings: data?['readings'] is Iterable
          ? List<Reading>.from(
              (data?['readings'] as List<dynamic>).map(
                (reading) => Reading.fromMap(reading as Map<String, dynamic>),
              ),
            )
          : null,
      writings: data?['writings'] is Iterable
          ? List<Writing>.from(
              (data?['writings'] as List<dynamic>).map(
                (writing) => Writing.fromMap(writing as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (authUserUid != null) "authUserUid": authUserUid,
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (readings != null)
        "readings": readings?.map((reading) => reading.toFirestore()).toList(),
      if (writings != null)
        "writings": writings?.map((writing) => writing.toFirestore()).toList(),
    };
  }
}
