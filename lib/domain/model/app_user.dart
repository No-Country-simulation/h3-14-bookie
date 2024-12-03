import 'package:h3_14_bookie/domain/model/reading.dart';
import 'package:h3_14_bookie/domain/model/writing.dart';

class AppUser {
  final String? name;
  final String? email;
  final String? role;
  final List<Reading> readings;
  final List<Writing> writings;

  AppUser(
      {required this.name,
      required this.email,
      required this.role,
      required this.readings,
      required this.writings});
}
