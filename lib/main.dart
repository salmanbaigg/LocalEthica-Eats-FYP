import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'home_screen.dart';
import 'list_page.dart';
import 'scan_page.dart';
import 'ai_recommendations.dart';
import 'discussion_forum.dart';
import 'reviews_page.dart';
import 'profile_page.dart';
import 'theme/app_theme.dart';
import 'edit_profile_page.dart';

void main() {
  runApp(const LocalEthicaEatsApp());
}

class LocalEthicaEatsApp extends StatelessWidget {
  const LocalEthicaEatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LocalEthica Eats',
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const HomeScreen(),
        '/list': (context) => const ListPage(),
        '/scan': (context) => const ScanPage(),
        '/ai': (context) => const AIRecommendations(),
        '/forum': (context) => const DiscussionForum(),
        '/reviews': (context) => const ReviewsPage(),
        '/profile': (context) => const ProfilePage(),
        '/edit-profile': (context) => const EditProfilePage(),

      },
      debugShowCheckedModeBanner: false,
    );
  }
}
