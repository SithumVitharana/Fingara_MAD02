import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class BookingServices {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addBooking({
    required String selectedDate,
    required String startTime,
    required String endTime,
    required String facility,
    required int price,
    required String userEmail,
  }) async {
    try {
      await _firestore.collection('Reservations').add({
        'date': selectedDate,
        'startTime': startTime,
        'endTime': endTime,
        'facility': facility,
        'price': price,
        'userEmail': userEmail,
      });
    } catch (e) {
      print('Error adding booking: $e');
    }
  }




  Future<List<Map<String, String>>> fetchReservedTimeSlots(String date) async {

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Reservations')
        .where('date', isEqualTo: date)
        .get();

    print('Query snapshot: ${querySnapshot.docs.length} documents found for date: $date'); // Debugging line

    List<Map<String, String>> reservedSlots = [];

    for (var doc in querySnapshot.docs) {
      reservedSlots.add({
        'start': doc['startTime'],
        'end': doc['endTime'],
      });
    }
    print('Reserved slots fetched: $reservedSlots'); // Debugging line
    return reservedSlots;
  }

  List<Map<String, String>> filterAvailableTimeSlots(
      List<Map<String, String>> allSlots, List<Map<String, String>> reservedSlots) {
    List<Map<String, String>> availableSlots = [];

    for (var slot in allSlots) {
      bool isReserved = reservedSlots.any((reservedSlot) {

        return (slot['start'] == reservedSlot['start'] || slot['end'] == reservedSlot['end']);
      });

      if (!isReserved) {
        availableSlots.add(slot);
      }
    }

    return availableSlots;
  }

}
