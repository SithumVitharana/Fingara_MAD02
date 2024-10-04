import 'package:fingara_mad02/pages/facilities.dart';
import 'package:fingara_mad02/pages/history.dart';
import 'package:fingara_mad02/pages/home.dart';
import 'package:fingara_mad02/pages/reservationPages/badminton_Reservation.dart';
import 'package:fingara_mad02/pages/reservationPages/squash_Reservation.dart';
import 'package:fingara_mad02/pages/reservationPages/tennis_Reservation.dart';
import 'package:flutter/material.dart';

class Reservations extends StatefulWidget {
  final int initialIndex;

  const Reservations({super.key, this.initialIndex = 0});

  @override
  State<Reservations> createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: widget.initialIndex,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: "Tennis"),
              Tab(text: "Badminton"),
              Tab(text: "Squash"),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Reservations', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
                child: const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/userProfile_MAD.jpg'),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: 2,
          onDestinationSelected: (index) {
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Facilities()),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Reservations(initialIndex: widget.initialIndex)), // Pass the initial index
                );
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const History()),
                );
                break;
            }
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.sports_tennis), label: 'Facilities'),
            NavigationDestination(icon: Icon(Icons.calendar_month), label: 'Reservations'),
            NavigationDestination(icon: Icon(Icons.access_time_outlined), label: 'History'),
          ],
        ),
        body: const TabBarView(
          children: [
            TennisReservations(),
            BadmintonReservations(),
            SquashReservations(),
          ],
        ),
      ),
    );
  }
}
