import 'package:velotolouse/model/bike/bike.dart';

abstract class BikeRepository {
  Future<List<Bike>> getAllBikes();
  Future<Bike?> getBikeById(String bikeId);
  Future<void> createBike(Bike bike);
  Future<void> updateBike(Bike bike);
  Future<void> deleteBike(String bikeId);
}
