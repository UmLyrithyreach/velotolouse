import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velotolouse/data/dto/user_dto.dart';
import 'package:velotolouse/data/repositories/user/user_abstract_repo.dart';
import 'package:velotolouse/model/user/user.dart';

// Firebase implementation data getting logic
class FirebaseUserRepository implements UserRepository {
  final FirebaseFirestore _firestore;

  FirebaseUserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<User>> getAllUsers() async {
    try {
      // Fetch all users from Firestore collection
      final snapshot = await _firestore.collection('users').get();

      // Convert each document using DTO and collect into list
      return snapshot.docs.map((doc) {
        return UserDto.fromFirestore(doc.id, doc.data());
      }).toList();
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  @override
  Future<User?> getUserById(String userId) async {
    try {
      // Fetch single user document by ID
      final doc = await _firestore.collection('users').doc(userId).get();

      if (!doc.exists) return null;

      // Convert document data to User using DTO
      return UserDto.fromFirestore(doc.id, doc.data()!);
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  @override
  Future<void> createUser(User user) async {
    try {
      // Convert User to map using DTO
      final userData = UserDto.toFirestore(user);

      // Store in Firestore using user ID as document ID
      await _firestore.collection('users').doc(user.id).set(userData);
    } catch (e) {
      print('Error creating user: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateUser(User user) async {
    try {
      // Convert User to map using DTO
      final userData = UserDto.toFirestore(user);

      // Update existing document
      await _firestore.collection('users').doc(user.id).update(userData);
    } catch (e) {
      print('Error updating user: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteUser(String userId) async {
    try {
      // Delete document by ID
      await _firestore.collection('users').doc(userId).delete();
    } catch (e) {
      print('Error deleting user: $e');
      rethrow;
    }
  }
}
