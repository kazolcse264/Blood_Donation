
import 'package:blood_donation/pages/donor_list_page.dart';
import 'package:blood_donation/pages/home_page.dart';
import 'package:blood_donation/pages/launcher_page.dart';
import 'package:blood_donation/pages/login_page.dart';
import 'package:blood_donation/pages/profile_page.dart';
import 'package:blood_donation/pages/registration_page.dart';
import 'package:blood_donation/providers/user_provder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        LoginPage.routeName: (context) => const LoginPage(),
        RegistrationPage.routeName: (context) => const RegistrationPage(),
        DonorListPage.routeName: (context) => const DonorListPage(),
        ProfilePage.routeName: (context) => const ProfilePage(),
        LauncherPage.routeName: (context) => const LauncherPage(),
      },
    );
  }
}
