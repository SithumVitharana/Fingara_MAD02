import 'package:fingara_mad02/pages/facilities.dart';
import 'package:fingara_mad02/pages/home.dart';
import 'package:fingara_mad02/pages/reservationPages/reservation_details.dart';
import 'package:fingara_mad02/pages/reservations.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../userDetails/user_services.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String userEmail = '';
  @override
  void initState() {
    super.initState();
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

  Future<List<Map<String, dynamic>>> _fetchReservations() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Reservations')
        .where('userEmail', isEqualTo: userEmail)
        .get();

    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
                'History',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                )
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: CircleAvatar(
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
        selectedIndex: 3,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.sports_tennis), label: 'Facilities'),
          NavigationDestination(icon: Icon(Icons.calendar_month), label: 'Reservations'),
          NavigationDestination(icon: Icon(Icons.access_time_outlined), label: 'History'),
        ],
      ),
      body: Column(
        children: [

          Container(
            height: 195,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/history_MAD.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchReservations(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No reservations found.'));
                }

                Map<String, List<Map<String, dynamic>>> groupedReservations = {};
                for (var reservation in snapshot.data!) {
                  String sport = reservation['facility'];
                  if (!groupedReservations.containsKey(sport)) {
                    groupedReservations[sport] = [];
                  }
                  groupedReservations[sport]!.add(reservation);
                }

                groupedReservations.removeWhere((key, value) => value.isEmpty);

                return ListView.builder(
                  itemCount: groupedReservations.keys.length,
                  itemBuilder: (context, index) {
                    String sport = groupedReservations.keys.elementAt(index);
                    List<Map<String, dynamic>> reservations = groupedReservations[sport]!;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sport,
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16),
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 108.0,
                              autoPlay: false,
                              enlargeCenterPage: true,
                            ),
                            items: reservations.map((reservation) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReservationDetails(reservation: reservation),
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 5,
                                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${reservation['facility']}',
                                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${reservation['date']}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              '${reservation['startTime']} - ${reservation['endTime']}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => Facilities()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => Reservations()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => History()));
        break;
      default:
        break;
    }
  }
}
