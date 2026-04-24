import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velotolouse/data/dto/bike_dto.dart';
import 'package:velotolouse/data/repositories/bike/bike_abstract_repo.dart';
import 'package:velotolouse/model/bike/bike.dart';

// Firebase implementation data getting logic
class FirebaseBikeRepository implements BikeRepository {
  final FirebaseFirestore _firestore;

  FirebaseBikeRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<Bike>> getAllBikes() async {
    try {
      // Fetch all bikes from Firestore collection
      final snapshot = await _firestore.collection('bikes').get();

      // Convert each document using DTO and collect into list
      return snapshot.docs.map((doc) {
        return BikeDto.fromFireStore(doc.id, doc.data());
      }).toList();
    } catch (e) {
      print('Error fetching bikes: $e');
      return [];
    }
  }

  @override
  Future<Bike?> getBikeById(String bikeId) async {
    try {
      // Fetch single bike document by ID
      final doc = await _firestore.collection('bikes').doc(bikeId).get();

      if (!doc.exists) return null;

      // Convert document data to Bike using DTO
      return BikeDto.fromFireStore(doc.id, doc.data()!);
    } catch (e) {
      print('Error fetching bike: $e');
      return null;
    }
  }

  @override
  Future<void> createBike(Bike bike) async {
    try {
      // Convert Bike to map using DTO
      final bikeData = BikeDto.toFireStore(bike);

      // Store in Firestore using bike ID as document ID
      await _firestore.collection('bikes').doc(bike.bikeId).set(bikeData);
    } catch (e) {
      print('Error creating bike: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateBike(Bike bike) async {
    try {
      // Convert Bike to map using DTO
      final bikeData = BikeDto.toFireStore(bike);

      // Update existing document
      await _firestore.collection('bikes').doc(bike.bikeId).update(bikeData);
    } catch (e) {
      print('Error updating bike: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteBike(String bikeId) async {
    try {
      // Delete document by ID
      await _firestore.collection('bikes').doc(bikeId).delete();
    } catch (e) {
      print('Error deleting bike: $e');
      rethrow;
    }
  }
}
