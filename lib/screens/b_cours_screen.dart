import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'en_cours_screen.dart'; // Import the En Cours screen

class BCurrentScreen extends StatefulWidget {
  const BCurrentScreen({Key? key}) : super(key: key);

  @override
  _BCurrentScreenState createState() => _BCurrentScreenState();
}

class _BCurrentScreenState extends State<BCurrentScreen> {
  double _currentBudget = 0.0;
  double _hotelBudget = 0.0;
  double _transportBudget = 0.0;
  double _activitiesBudget = 0.0;
  double _foodBudget = 0.0; // New Food budget
  double _otherBudget = 0.0;
  final TextEditingController _budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120), // Increased height
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 22,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Budget Actuel',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24, // Adjusted font size
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEAEAEA), Color(0xFFF1F1BC)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Circular budget display
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '€${_currentBudget.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5A4500),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Expense Categories
                _buildExpenseBars(),
                const SizedBox(height: 20),
                // Input field for budget
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _budgetController,
                    decoration: InputDecoration(
                      labelText: 'Ajouter un budget',
                      labelStyle: const TextStyle(color: Color(0xFF7A6420)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Color(0xFFDAAC2A), width: 1.5),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 20),
                // Add button
                ElevatedButton(
                  onPressed: () {
                    double? newBudget = double.tryParse(_budgetController.text);
                    if (newBudget != null) {
                      setState(() {
                        _currentBudget += newBudget;
                        // Allocate the new budget to the "Autre" category
                        _otherBudget +=
                            newBudget; // All new budget goes to Autre
                        _budgetController.clear();
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDAAC2A),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                  child: const Text(
                    'Ajouter',
                    style: TextStyle(color: Colors.white), // Changed to white
                  ),
                ),
                const SizedBox(height: 20),
                // Submit button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const EnCoursScreen()), // Navigate to En Cours screen
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDAAC2A),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                  child: const Text(
                    'Soumettre',
                    style: TextStyle(color: Colors.white), // Changed to white
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFEAEAEA), Color(0xFFE8E4A0)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, -1),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Accueil'),
            BottomNavigationBarItem(
                icon: Icon(Icons.now_widgets), label: 'En cours'),
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_money), label: 'Budget'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: 'Profil'),
          ],
          currentIndex: 2,
          selectedItemColor: Color(0xFFDAAC2A),
          unselectedItemColor: Color(0xFF7A6420),
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
                break;
              case 1:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const EnCoursScreen()), // Navigate to En Cours screen
                );
                break;
              case 2:
                // Already on Budget screen
                break;
              case 3:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                );
                break;
            }
          },
        ),
      ),
    );
  }

  Widget _buildExpenseBars() {
    return Column(
      children: [
        _buildExpenseBar('Hôtels', _hotelBudget),
        _buildExpenseBar('Transport', _transportBudget),
        _buildExpenseBar('Activités', _activitiesBudget),
        _buildExpenseBar('Food', _foodBudget), // New Food category
        _buildExpenseBar('Autre', _otherBudget),
      ],
    );
  }

  Widget _buildExpenseBar(String title, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title),
                    Text('€${amount.toStringAsFixed(2)}'),
                  ],
                ),
                const SizedBox(height: 5), // Space between title and bar
                Container(
                  height: 30, // Increased height for better visibility
                  decoration: BoxDecoration(
                    color: const Color(0xFFDAAC2A), // Bar color
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: _currentBudget > 0
                      ? (amount / _currentBudget) * 200
                      : 0, // Adjust width based on budget
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }
}
