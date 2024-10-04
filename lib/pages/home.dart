import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fingara_mad02/pages/facilities.dart';
import 'package:fingara_mad02/pages/history.dart';
import 'package:fingara_mad02/pages/reservations.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final LatLng _fingaraLocation = LatLng(6.851589885289997, 79.89923503953895);

  GoogleMapController? _mapController;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Facilities()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Reservations()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => History()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> carouselItems = [
      {
        'image': 'assets/images/wineNDine_Services.png',
        'title': 'Wine and Dine',
        'description': 'Enjoy some delicious food prepared by our brilliant chefs varying from mouthwatering eastern to western foods.'
      },
      {
        'image': 'assets/images/banquetHalls_Services.jpg',
        'title': 'Banquet Halls',
        'description': 'Our Banquet Hall can easily accommodate and cater up to 250 - 300 pax at any given time.'
      },
      {
        'image': 'assets/images/swimmingPools_Services.jpg',
        'title': 'Swimming Pool',
        'description': 'Our swimming pool is situated within the club under a perfect setting. Many consider this pool to be one of the clearest in Sri Lanka.'
      },
      {
        'image': 'assets/images/gymnasium_Services.webp',
        'title': 'Gymnasium',
        'description': 'The club is equipped with a modern gymnasium with the latest exercising equipment. Professional gym instructors are at hand to provide individual attention to all members.'
      },
      {
        'image': 'assets/images/sportsFacilities_Services.jpg',
        'title': 'Sports Facilities',
        'description': 'Providing you with a chance to get an hour of fast and furious exercise before you leave for work with facilities such as Badminton, Tennis and Squash.'
      },
      {
        'image': 'assets/images/kidsPlayArea_Services.jpeg',
        'title': 'Kids Play Area',
        'description': 'Our country club offers a vibrant and safe kids play area designed to spark imagination and fun. With a variety of engaging play structures and secure surroundings.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
                'Home',
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
        height: 70,
        selectedIndex: _selectedIndex,
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
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 27),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Fingara",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
              Text(
                "Town and Country Club",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "The Fingara Family Club designed with a novel, modern and functional concept presents you a unique holiday experience.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/homeIntroTitle_MAD.jpg',
                  width: double.infinity,
                  height: MediaQuery.of(context).orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.height * 0.3
                      : MediaQuery.of(context).size.height * 0.5,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Celebrating 21 Years in the Hospitality Industry",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Completely cut off from the busy complexities of Colombo, yet situated within its city limits, is the serenely beautiful Fingara Town and Country Club. Located at Boralesgamuwa.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 18),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _fingaraLocation,
                      zoom: 15.0,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId('fingara-location'),
                        position: _fingaraLocation,
                        infoWindow: InfoWindow(
                          title: 'Fingara Club',
                          snippet: 'Boralesgamuwa, Sri Lanka',
                        ),
                      ),
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "A host of facilities, unheard of elsewhere, are at your disposal. Enjoy our Swimming Pool, Tennis, Badminton, Basketball, Squash, Table Tennis, Indoor Games, Pool, Cricket Nets, Modern Gymnasium, Kids Play Area, Restaurant & Pub, Coffee Shop, Seminar, Conference and Banqueting Halls.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "The Club also offers fabulous dining outside on the terrace or in the confines of the cozy atmosphere.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Services",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.height * 0.4
                      : MediaQuery.of(context).size.height * 0.75,
                ),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: double.infinity,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                  ),
                  items: carouselItems.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).colorScheme.surfaceBright,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8.0,
                                spreadRadius: 2.0,
                                offset: Offset(2, 2),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                child: Image.asset(
                                  item['image']!,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 3),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item['title']!,
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,

                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Text(
                                  item['description']!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 18,),
            ],
          ),
        ),
      ),
    );
  }
}
