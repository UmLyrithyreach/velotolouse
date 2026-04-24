class Booking {
  String id;
  String userId;
  String bikeId;
  DateTime startTime;
  DateTime endTime;
  double price;

  Booking({
    required this.id,
    required this.userId,
    required this.bikeId,
    required this.startTime,
    required this.endTime,
    required this.price,
  });

  @override
  String toString() {
    return "Booking(id: $id, userId: $userId, bikeId: $bikeId, startTime: $startTime, endTime: $endTime, price: $price)";
  }
}