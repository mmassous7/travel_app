import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: const Color(0xFFDAAC2A),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEAEAEA), Color(0xFFF1F1BC)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.notifications,
                size: 100,
                color: Color(0xFFDAAC2A),
              ),
              const SizedBox(height: 20),
              const Text(
                'No new notifications',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5A4500),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Stay tuned for updates!',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF7A6420),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
