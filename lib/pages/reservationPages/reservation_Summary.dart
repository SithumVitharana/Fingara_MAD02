import 'package:fingara_mad02/bookingServices/booking_services.dart';
import 'package:flutter/material.dart';
import '../../bookingServices/stripe_services.dart';
import '../history.dart';

class ReservationSummary extends StatelessWidget {
  final String selectedDate;
  final String selectedTime;
  final String selectedStartTime;
  final String selectedEndTime;
  final String email;
  final int price;
  final String facility;

  final BookingServices bookingService = BookingServices();

  ReservationSummary({
    Key? key,
    required this.selectedDate,
    required this.selectedTime,
    required this.email,
    required this.price,
    required this.facility,
    required this.selectedStartTime,
    required this.selectedEndTime,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text(
            'Reservation Summary',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
            )
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reservation Details',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Using a Card widget for a cleaner look
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.sports_tennis, size: 20), // Tennis icon
                        const SizedBox(width: 8),
                        Text('Facility: $facility', style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 20),
                        const SizedBox(width: 8),
                        Text('Date: $selectedDate', style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 20),
                        const SizedBox(width: 8),
                        Text('Time: $selectedTime', style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.email, size: 20),
                        const SizedBox(width: 8),
                        Text('Email: $email', style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.monetization_on, size: 20),
                        const SizedBox(width: 8),
                        Text('Total Price: \Rs ${price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                ),
                onPressed: () async {

                  await StripeService.stripeInstance.makePayment(
                    amount: price,
                    addBooking: () {
                      bookingService.addBooking(
                        selectedDate: selectedDate,
                        startTime: selectedStartTime,
                        endTime: selectedEndTime,
                        facility: facility,
                        price: price,
                        userEmail: email,
                      );
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => History(),
                        ),
                      );
                    },
                  );
                },
                child: const Text('Proceed to Payment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
