import 'package:flutter/material.dart';
import 'budget_screen.dart'; // Import the budget screen

class ActivitiesScreen extends StatelessWidget {
  final String destinationName;

  const ActivitiesScreen({Key? key, required this.destinationName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8E0),
      appBar: AppBar(
        title: Text('Activities in $destinationName'),
        backgroundColor: const Color(0xFFDAAC2A),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildActivityCard(
              'Guided City Tour', 'Explore the city with a local guide', 50),
          _buildActivityCard(
              'Wine Tasting', 'Enjoy local wines and cheeses', 30),
          _buildActivityCard(
              'Hiking Adventure', 'Experience the great outdoors', 40),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to budget screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      BudgetScreen(estimatedBudget: 200), // Example budget
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDAAC2A),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Next: Budget',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(String title, String description, double price) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 8),
            Text('\$$price', style: const TextStyle(color: Color(0xFFDAAC2A))),
          ],
        ),
      ),
    );
  }
}
