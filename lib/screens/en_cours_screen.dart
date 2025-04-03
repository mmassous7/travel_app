import 'package:flutter/material.dart';

class EnCoursScreen extends StatelessWidget {
  const EnCoursScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEAEAEA), Color(0xFFF1F1BC)],
          ),
        ),
        child: Column(
          children: [
            PreferredSize(
              preferredSize: const Size.fromHeight(120),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF6B6B6B), Color(0xFFDAAC2A)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 24,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Voyage Actuel',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.all(16.0), // Padding autour du contenu
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Aperçu du Voyage Actuel
                    _buildCurrentVoyageOverview(),
                    const SizedBox(height: 20),
                    // Section Itinéraire
                    _buildItinerarySection(),
                    const SizedBox(height: 20),
                    // Gestion du Budget
                    _buildBudgetTracker(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentVoyageOverview() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.only(bottom: 20), // Marge entre les cartes
      child: Padding(
        padding: const EdgeInsets.all(20.0), // Padding interne
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Aperçu du Voyage Actuel',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const Text('Destination: Paris', style: TextStyle(fontSize: 18)),
            const Text('Durée: 5 jours', style: TextStyle(fontSize: 18)),
            const Text(
                'Activités: Tour Eiffel, Musée du Louvre, Croisière sur la Seine',
                style: TextStyle(fontSize: 18)),
            const Text('Budget: €1000', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget _buildItinerarySection() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.only(bottom: 20), // Marge entre les cartes
      child: Padding(
        padding: const EdgeInsets.all(20.0), // Padding interne
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Itinéraire',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Divider(),
            _buildItineraryItem('Jour 1: Arrivée à Paris'),
            _buildItineraryItem('Jour 2: Visite de la Tour Eiffel'),
            _buildItineraryItem('Jour 3: Visite du Musée du Louvre'),
            _buildItineraryItem('Jour 4: Croisière sur la Seine'),
            _buildItineraryItem('Jour 5: Départ'),
          ],
        ),
      ),
    );
  }

  Widget _buildItineraryItem(String activity) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text('• $activity', style: const TextStyle(fontSize: 18)),
    );
  }

  Widget _buildBudgetTracker() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.only(bottom: 20), // Marge entre les cartes
      child: Padding(
        padding: const EdgeInsets.all(20.0), // Padding interne
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Suivi du Budget',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const Text('Budget Total: €1000', style: TextStyle(fontSize: 18)),
            const Text('Dépensé: €600', style: TextStyle(fontSize: 18)),
            const Text('Restant: €400', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: 0.6, // 60% dépensé
              backgroundColor: Colors.grey[300],
              color: const Color(0xFFDAAC2A),
            ),
          ],
        ),
      ),
    );
  }
}
