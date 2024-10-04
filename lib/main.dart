import 'package:fingara_mad02/consts.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'theme/theme_provider.dart';
import 'pages/profile.dart';
import 'authentication/login.dart';
import 'authentication/register.dart';
import 'pages/facilities.dart';
import 'pages/history.dart';
import 'pages/home.dart';
import 'pages/landing.dart';
import 'pages/reservations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _setup();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

Future<void> _setup() async {
  Stripe.publishableKey = stripePublishableKey;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/home': (context) => const Home(),
        '/facilities': (context) => const Facilities(),
        '/reservations': (context) => const Reservations(),
        '/history': (context) => History(),
        '/profile': (context) => const Profile(),
      },
    );
  }
}
