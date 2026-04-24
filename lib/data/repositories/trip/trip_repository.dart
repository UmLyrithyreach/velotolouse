import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velotolouse/data/dto/trip_dto.dart';
import 'package:velotolouse/data/repositories/trip/trip_abstract_repo.dart';
import 'package:velotolouse/model/trip/trip.dart';

// Firebase implementation data getting logic
class FirebaseTripRepository implements TripRepository {
  final FirebaseFirestore _firestore;

  FirebaseTripRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<Trip>> getAllTrips() async {
    try {
      // Fetch all trips from Firestore collection
      final snapshot = await _firestore.collection('trips').get();

      // Convert each document using DTO and collect into list
      return snapshot.docs.map((doc) {
        return TripDto.fromFirestore(doc.id, doc.data());
      }).toList();
    } catch (e) {
      print('Error fetching trips: $e');
      return [];
    }
  }

  @override
  Future<Trip?> getTripById(String tripId) async {
    try {
      // Fetch single trip document by ID
      final doc = await _firestore.collection('trips').doc(tripId).get();

      if (!doc.exists) return null;

      // Convert document data to Trip using DTO
      return TripDto.fromFirestore(doc.id, doc.data()!);
    } catch (e) {
      print('Error fetching trip: $e');
      return null;
    }
  }

  @override
  Future<List<Trip>> getTripsByUserId(String userId) async {
    try {
      // Query trips by userId field
      final snapshot = await _firestore
          .collection('trips')
          .where('userId', isEqualTo: userId)
          .get();

      // Convert each document using DTO and collect into list
      return snapshot.docs.map((doc) {
        return TripDto.fromFirestore(doc.id, doc.data());
      }).toList();
    } catch (e) {
      print('Error fetching trips for user: $e');
      return [];
    }
  }

  @override
  Future<void> createTrip(Trip trip) async {
    try {
      // Convert Trip to map using DTO
      final tripData = TripDto.toFirestore(trip);

      // Store in Firestore using trip ID as document ID
      await _firestore.collection('trips').doc(trip.id).set(tripData);
    } catch (e) {
      print('Error creating trip: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateTrip(Trip trip) async {
    try {
      // Convert Trip to map using DTO
      final tripData = TripDto.toFirestore(trip);

      // Update existing document
      await _firestore.collection('trips').doc(trip.id).update(tripData);
    } catch (e) {
      print('Error updating trip: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteTrip(String tripId) async {
    try {
      // Delete document by ID
      await _firestore.collection('trips').doc(tripId).delete();
    } catch (e) {
      print('Error deleting trip: $e');
      rethrow;
    }
  }
}
