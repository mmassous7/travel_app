import 'package:flutter/material.dart';
import 'activities_screen.dart'; // Import the activities screen

class HotelDetailsScreen extends StatelessWidget {
  final String destinationName;

  const HotelDetailsScreen({Key? key, required this.destinationName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8E0),
      appBar: AppBar(
        title: Text('Hôtels à $destinationName'),
        backgroundColor: const Color(0xFFDAAC2A),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        // Added scrollable functionality
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHotelCard('Hotel Lux', '5 étoiles, luxe', 200,
                  'assets/images/hotel1.jpg'),
              _buildHotelCard('Budget Inn', 'Séjour abordable', 80,
                  'assets/images/hotel2.jpg'),
              _buildHotelCard('Cozy Cottage', 'Séjour charmant à la campagne',
                  120, 'assets/images/hotel3.jpg'),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to activities screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ActivitiesScreen(destinationName: destinationName),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDAAC2A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Suivant : Activités',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHotelCard(
      String name, String description, double price, String imageUrl) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover, // Adjusts the image to cover the space
              height: 150, // Set a fixed height for the image
              width: double.infinity, // Makes the image take full width
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(description, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text('\$$price par nuit',
                    style: const TextStyle(
                      color: Color(0xFFDAAC2A),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Action for booking
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDAAC2A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Réserver'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Action for more details
                      },
                      child: const Text(
                        'Détails',
                        style: TextStyle(color: Color(0xFFDAAC2A)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
