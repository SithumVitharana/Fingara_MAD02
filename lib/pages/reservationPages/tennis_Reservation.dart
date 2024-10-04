import 'package:fingara_mad02/pages/reservationPages/reservation_Summary.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../bookingServices/booking_services.dart';
import '../../userDetails/user_services.dart';

class TennisReservations extends StatefulWidget {
  const TennisReservations({Key? key}) : super(key: key);

  @override
  State<TennisReservations> createState() => _TennisReservationsState();
}

class _TennisReservationsState extends State<TennisReservations> {
  DateTime selectedDate = DateTime.now();
  Map<String, String>? selectedSlot;
  List<Map<String, String>> availableTimeSlots = [];
  String userEmail = "";
  String errorMessage = "";

  final int hourlyPrice = 3000;

  final List<Map<String, String>> allTimeSlots = [
    {'start': '7:00 AM', 'end': '8:00 AM'},
    {'start': '8:00 AM', 'end': '9:00 AM'},
    {'start': '9:00 AM', 'end': '10:00 AM'},
    {'start': '10:00 AM', 'end': '11:00 AM'},
    {'start': '11:00 AM', 'end': '12:00 PM'},
    {'start': '12:00 PM', 'end': '1:00 PM'},
    {'start': '1:00 PM', 'end': '2:00 PM'},
    {'start': '2:00 PM', 'end': '3:00 PM'},
    {'start': '3:00 PM', 'end': '4:00 PM'},
    {'start': '4:00 PM', 'end': '5:00 PM'},
    {'start': '5:00 PM', 'end': '6:00 PM'},
    {'start': '6:00 PM', 'end': '7:00 PM'},
    {'start': '7:00 PM', 'end': '8:00 PM'},
    {'start': '8:00 PM', 'end': '9:00 PM'},
    {'start': '9:00 PM', 'end': '10:00 PM'},
    {'start': '10:00 PM', 'end': '11:00 PM'},
  ];

  BookingServices bookingService = BookingServices();

  @override
  void initState() {
    super.initState();
    _loadAvailableSlots(selectedDate);
    _getUserEmail();
  }

  Future<void> _getUserEmail() async {
    UserService userService = UserService();
    Map<String, dynamic>? userData = await userService.getUserDetails();

    if (userData != null) {
      setState(() {
        userEmail = userData['email'] ?? '';
      });
    }
  }

  Future<void> _loadAvailableSlots(DateTime date) async {

    String formattedDate = DateFormat('EEE, MMM d, y').format(date);
    List<Map<String, String>> reservedSlots = await bookingService.fetchReservedTimeSlots(formattedDate);
    List<Map<String, String>> filteredSlots = bookingService.filterAvailableTimeSlots(allTimeSlots, reservedSlots);

    setState(() {
      availableTimeSlots = filteredSlots;
    });
  }

  void resetFields() {
    setState(() {
      selectedDate = DateTime.now();
      selectedSlot = null;
      errorMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('E, MMM d, y').format(selectedDate); // Change the date format here

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/tennisReservation_Equipment.jpg',
              width: double.infinity,
              height: MediaQuery.of(context).orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.height * 0.3
                  : MediaQuery.of(context).size.height * 0.5,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 25),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Date',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Selected Date: $formattedDate', // Use the formatted date here
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 16),

                  TableCalendar(
                    focusedDay: selectedDate,
                    firstDay: DateTime.now(),
                    lastDay: DateTime(2025),
                    calendarFormat: CalendarFormat.month,
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        selectedDate = selectedDay;
                      });
                      _loadAvailableSlots(selectedDate);
                    },
                    selectedDayPredicate: (day) {
                      return isSameDay(selectedDate, day);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Available Time Slots',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_forever),
                        onPressed: resetFields,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 4,
                    ),
                    itemCount: availableTimeSlots.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final slot = availableTimeSlots[index];
                      final isSelected = selectedSlot == slot;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            // Toggle selection: if already selected, deselect it
                            if (isSelected) {
                              selectedSlot = null;
                            } else {
                              selectedSlot = slot;
                            }
                            errorMessage = '';
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: isSelected ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.outline,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Text('${slot['start']} - ${slot['end']}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                  fontWeight: FontWeight.bold,
                                ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              ),
              onPressed: () async {
                if (selectedSlot != null && errorMessage.isEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReservationSummary(
                        selectedDate: DateFormat.yMMMEd().format(selectedDate),
                        selectedTime: '${selectedSlot!['start']} - ${selectedSlot!['end']}',
                        selectedStartTime: '${selectedSlot!['start']}',
                        selectedEndTime: '${selectedSlot!['end']}',
                        email: userEmail,
                        price: hourlyPrice,
                        facility: 'Tennis Facility',
                      ),
                    ),
                  );
                } else {
                  setState(() {
                    errorMessage = 'Please select a time slot.';
                  });
                }
              },
              child: const Text('Proceed to Summary'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
