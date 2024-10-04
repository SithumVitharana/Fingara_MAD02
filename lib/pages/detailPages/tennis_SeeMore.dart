import 'package:flutter/material.dart';
import 'package:fingara_mad02/pages/facilities.dart';
import 'package:fingara_mad02/pages/history.dart';
import 'package:fingara_mad02/pages/home.dart';
import 'package:fingara_mad02/pages/reservations.dart';

class TennisSeeMore extends StatefulWidget {
  const TennisSeeMore({super.key});

  @override
  State<TennisSeeMore> createState() => _TennisSeeMoreState();
}

class _TennisSeeMoreState extends State<TennisSeeMore> {
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
            const Text('Tennis Facility', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                'assets/images/tennisSeeMore_Title.jpeg',
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
                    'Tennis Courts',
                    style: TextStyle(fontSize: 26 , fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Our outdoor tennis courts at the country club provide a premier setting for enjoying the game. Surrounded by lush landscaping and open skies, the courts offer a scenic and tranquil environment. The well-maintained surfaces and amenities ensure a top-notch playing experience, whether you\'re here for a friendly match or a competitive game.',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/tennisSeeMore_Details.jpg',
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
                      'Surface: High-quality hard court with excellent grip, ideal for both casual games and competitive matches.',
                      'Lighting: Well-lit courts with LED lighting for optimal visibility during evening play.',
                      'Booking: Available for individual or group bookings, with options for regular weekly slots.',
                      'Operating Hours: Open daily from 7:00 AM to 11:00 PM.',
                      'Dress Code: Tennis attire and shoes required.',
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
                      'assets/images/tennisSeeMore_Equipment.webp',
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
                      'Booking: Courts must be reserved in advance. No walk-on play is allowed without a reservation.',
                      'Attire: Proper tennis attire and non-marking tennis shoes are required. Casual or inappropriate clothing is not permitted.',
                      'Equipment: Players must use appropriate tennis equipment. No other sports equipment is allowed on the courts.',
                      'Court Etiquette: Respect other players’ games and avoid disruptive behavior. Maintain a clean environment and dispose of trash properly. Do not bring food or drinks onto the court.',
                      'Court Usage: Play is limited to 1 hour per session. Please vacate the court promptly at the end of your booking time.',
                      'Lights Usage: Courts equipped with lights may be used until closing time. Ensure lights are turned off after use.',
                      'Children: Children under the age of 14 must be accompanied by an adult.',
                      'Damage: Report any damage or maintenance issues to the club staff immediately.',
                      'Conduct: Any form of unsportsmanlike conduct or abuse towards other players or staff will not be tolerated and may result in suspension of court privileges.'
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

    final boldParts = ['Surface:', 'Lighting:', 'Booking:', 'Operating Hours:', 'Dress Code:', 'Attire:', 'Equipment:', 'Court Etiquette:', 'Court Usage:', 'Lights Usage:', 'Children:', 'Damage:', 'Conduct:'];

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
