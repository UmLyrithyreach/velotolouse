class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String? activeBookingId;
  final String? activeTripId;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.activeBookingId,
    this.activeTripId,
  });

  @override
  String toString() {
    return "User(id: $id, name: $name, email: $email)";
  }
}