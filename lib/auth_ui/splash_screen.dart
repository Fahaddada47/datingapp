import 'package:datingapp/auth_ui/welcome_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bottom_nav_bar/ui/bottom_nav_bar_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHome(); // Renamed the method to better reflect the action
  }

  Future<void> navigateToHome() async {
    print('Navigate to Home called');
    await Future.delayed(Duration(seconds: 8 ));
    Get.offAll(() => WelcomePageScreen());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/img_5.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'version 1.0.1',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
