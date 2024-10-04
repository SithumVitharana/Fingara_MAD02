import 'package:fingara_mad02/pages/detailPages/badminton_SeeMore.dart';
import 'package:fingara_mad02/pages/detailPages/squash_SeeMore.dart';
import 'package:fingara_mad02/pages/detailPages/tennis_SeeMore.dart';
import 'package:fingara_mad02/pages/history.dart';
import 'package:fingara_mad02/pages/home.dart';
import 'package:fingara_mad02/pages/reservationPages/badminton_Reservation.dart';
import 'package:fingara_mad02/pages/reservationPages/squash_Reservation.dart';
import 'package:fingara_mad02/pages/reservationPages/tennis_Reservation.dart';
import 'package:fingara_mad02/pages/reservations.dart';
import 'package:flutter/material.dart';

class Facilities extends StatefulWidget {
  const Facilities({super.key});

  @override
  State<Facilities> createState() => _FacilitiesState();
}

class _FacilitiesState extends State<Facilities> {
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

  Widget _buildFacilityCard({
    required String title,
    required String image,
    required String description,
    required Widget seeMorePage,
    required Widget reserveNowPage,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
            const SizedBox(height: 12),

            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),

            const SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.inverseSurface,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => seeMorePage),
                    );
                  },
                  child: Text("See More"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => reserveNowPage),
                    );
                  },
                  child: Text("Reserve Now"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Facilities', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sports Facilities",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "The country club offers world-class sports facilities, including well-maintained courts for badminton, tennis, and squash. Each facility is designed to provide an excellent playing experience, with modern equipment and professional-grade surfaces.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),

              _buildFacilityCard(
                title: "Tennis",
                image: "assets/images/tennisCourt_FacilitySelector.jpg",
                description: "Our tennis courts are of championship quality with durable surfaces and ample seating for spectators.",
                seeMorePage: TennisSeeMore(),
                reserveNowPage: const Reservations(initialIndex: 0),
              ),

              _buildFacilityCard(
                title: "Badminton",
                image: "assets/images/badmintonCourt_FacilitySelector.jpeg",
                description: "Our badminton courts offer a professional playing experience with excellent lighting, wooden floors, and top-quality equipment.",
                seeMorePage: BadmintonSeeMore(),
                reserveNowPage: const Reservations(initialIndex: 1),
              ),

              _buildFacilityCard(
                title: "Squash",
                image: "assets/images/squashCourt_FacilitySelector.jpg",
                description: "Experience fast-paced games in our modern squash courts, complete with professional-grade walls and flooring.",
                seeMorePage: SquashSeeMore(),
                reserveNowPage: const Reservations(initialIndex: 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
