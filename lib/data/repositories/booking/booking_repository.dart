import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velotolouse/data/dto/booking_dto.dart';
import 'package:velotolouse/data/repositories/booking/booking_abstract_repo.dart';
import 'package:velotolouse/model/booking/booking.dart';

// Firebase implementation data fetching logic lives here only
class FirebaseBookingRepository implements BookingRepository {
  final FirebaseFirestore _firestore;

  FirebaseBookingRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<Booking>> getAllBookings() async {
    try {
      // Fetch all bookings from Firestore collection
      final snapshot = await _firestore.collection('bookings').get();

      // Convert each document using DTO and collect into list
      return snapshot.docs.map((doc) {
        return BookingDto.fromFirestore(doc.id, doc.data());
      }).toList();
    } catch (e) {
      print('Error fetching bookings: $e');
      return [];
    }
  }

  @override
  Future<Booking?> getBookingById(String bookingId) async {
    try {
      // Fetch single booking document by ID
      final doc = await _firestore.collection('bookings').doc(bookingId).get();

      if (!doc.exists) return null;

      // Convert document data to Booking using DTO
      return BookingDto.fromFirestore(doc.id, doc.data()!);
    } catch (e) {
      print('Error fetching booking: $e');
      return null;
    }
  }

  @override
  Future<List<Booking>> getBookingsByUserId(String userId) async {
    try {
      // Query bookings by userId field
      final snapshot = await _firestore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .get();

      // Convert each document using DTO and collect into list
      return snapshot.docs.map((doc) {
        return BookingDto.fromFirestore(doc.id, doc.data());
      }).toList();
    } catch (e) {
      print('Error fetching bookings for user: $e');
      return [];
    }
  }

  @override
  Future<void> createBooking(Booking booking) async {
    try {
      // Convert Booking to map using DTO
      final bookingData = BookingDto.toFirestore(booking);

      // Store in Firestore using booking ID as document ID
      await _firestore.collection('bookings').doc(booking.id).set(bookingData);
    } catch (e) {
      print('Error creating booking: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateBooking(Booking booking) async {
    try {
      // Convert Booking to map using DTO
      final bookingData = BookingDto.toFirestore(booking);

      // Update existing document
      await _firestore.collection('bookings').doc(booking.id).update(bookingData);
    } catch (e) {
      print('Error updating booking: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteBooking(String bookingId) async {
    try {
      // Delete document by ID
      await _firestore.collection('bookings').doc(bookingId).delete();
    } catch (e) {
      print('Error deleting booking: $e');
      rethrow;
    }
  }
}
