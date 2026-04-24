import 'package:velotolouse/model/trip/trip.dart';

abstract class TripRepository {
  Future<List<Trip>> getAllTrips();
  Future<Trip?> getTripById(String tripId);
  Future<List<Trip>> getTripsByUserId(String userId);
  Future<void> createTrip(Trip trip);
  Future<void> updateTrip(Trip trip);
  Future<void> deleteTrip(String tripId);
}