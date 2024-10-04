import 'package:flutter/material.dart';
import 'package:fingara_mad02/pages/facilities.dart';
import 'package:fingara_mad02/pages/history.dart';
import 'package:fingara_mad02/pages/home.dart';
import 'package:fingara_mad02/pages/reservations.dart';

class SquashSeeMore extends StatefulWidget {
  const SquashSeeMore({super.key});

  @override
  State<SquashSeeMore> createState() => _SquashSeeMoreState();
}

class _SquashSeeMoreState extends State<SquashSeeMore> {
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Facilities()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Reservations()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => History()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLandscape = screenWidth > screenHeight;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Squash Facility', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
        selectedIndex: 1,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.sports_tennis), label: 'Facilities'),
          NavigationDestination(icon: Icon(Icons.calendar_month), label: 'Reservations'),
          NavigationDestination(icon: Icon(Icons.access_time_outlined), label: 'History'),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Image.asset(
                'assets/images/squashSeeMore_Title.jpg',
                width: double.infinity,
                height: MediaQuery.of(context).orientation == Orientation.portrait
                    ? MediaQuery.of(context).size.height * 0.3
                    : MediaQuery.of(context).size.height * 0.48,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Squash Courts',
                    style: TextStyle(fontSize: 26 , fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Our squash courts at the club are equipped with the finest materials, designed for all levels of play. Whether you\'re here for a friendly match or competitive play, the courts provide an excellent environment. With a sleek design and air-conditioned surroundings, you\'ll have an exceptional squash experience.',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/squashSeeMore_Details.jpeg',
                      width: double.infinity,
                      height: MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height * 0.3
                          : MediaQuery.of(context).size.height * 0.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    'Facility Details',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  BulletPointList(
                    items: [
                      'Court Surface: Professional-grade hardwood flooring, providing excellent bounce and durability.',
                      'Lighting: Bright LED lights for optimal visibility during matches.',
                      'Booking: Available for single or group bookings, with flexible time slots.',
                      'Operating Hours: Open daily from 7:00 AM to 10:00 PM.',
                      'Dress Code: Squash-specific attire and non-marking shoes are required.',
                    ],
                    fontSize: 18,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Rules and Regulations',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/squashSeeMore_Equipment.jpg',
                      width: double.infinity,
                      height: MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height * 0.3
                          : MediaQuery.of(context).size.height * 0.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),

                  BulletPointList(
                    items: [
                      'Booking: Advance reservation is required. Walk-ins without a booking are not permitted.',
                      'Attire: Proper squash attire and non-marking shoes are mandatory.',
                      'Equipment: Only squash-specific equipment is allowed. No other sports equipment is permitted.',
                      'Court Etiquette: Players should maintain silence and avoid disruptive behavior. Dispose of trash properly.',
                      'Court Usage: Play is limited to 1 hour per session. Please vacate the court promptly after your session ends.',
                      'Lighting: Switch off lights after your booking session, especially during evening play.',
                      'Children: Children below 14 must be accompanied by an adult at all times.',
                      'Damage: Report any damages or maintenance issues to the staff immediately.',
                      'Conduct: Unsportsmanlike behavior or disrespect towards staff or other players may result in suspension of privileges.'
                    ],
                    fontSize: 18,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BulletPointList extends StatelessWidget {
  final List<String> items;
  final double fontSize;

  const BulletPointList({required this.items, required this.fontSize, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('• ', style: TextStyle(fontSize: 20)),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: _buildTextSpan(item),
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
          .toList(),
    );
  }

  List<TextSpan> _buildTextSpan(String item) {
    final boldParts = ['Court Surface:', 'Lighting:', 'Booking:', 'Operating Hours:', 'Dress Code:', 'Attire:', 'Equipment:', 'Court Etiquette:', 'Court Usage:', 'Lighting:', 'Children:', 'Damage:', 'Conduct:'];

    for (String boldText in boldParts) {
      if (item.startsWith(boldText)) {
        return [
          TextSpan(
            text: boldText,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: item.substring(boldText.length),
          ),
        ];
      }
    }

    return [TextSpan(text: item)];
  }
}
