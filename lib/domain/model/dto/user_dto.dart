class UserDto {
  String authUserUid;
  String? name;
  String email;

  UserDto({required this.authUserUid, this.name, required this.email});
}
