import 'package:velotolouse/model/booking/booking.dart';

abstract class BookingRepository {
  Future<List<Booking>> getAllBookings();
  Future<Booking?> getBookingById(String bookingId);
  Future<List<Booking>> getBookingsByUserId(String userId);
  Future<void> createBooking(Booking booking);
  Future<void> updateBooking(Booking booking);
  Future<void> deleteBooking(String bookingId);
}