import 'package:flutter/material.dart';

class BCurrentScreen extends StatefulWidget {
  const BCurrentScreen({Key? key}) : super(key: key);

  @override
  _BCurrentScreenState createState() => _BCurrentScreenState();
}

class _BCurrentScreenState extends State<BCurrentScreen> {
  double _currentBudget = 0.0;
  final TextEditingController _budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Actuel'),
        backgroundColor: const Color(0xFFDAAC2A), // Match theme color
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
                      color: Color(0xFF5A4500), // Match text color
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Input field for budget
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _budgetController,
                  decoration: InputDecoration(
                    labelText: 'Ajouter un budget',
                    labelStyle: const TextStyle(
                        color: Color(0xFF7A6420)), // Match label color
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
                      _budgetController.clear();
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFFDAAC2A), // Match button color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text('Ajouter'),
              ),
              const SizedBox(height: 20),
              // Submit button
              ElevatedButton(
                onPressed: () {
                  // Handle budget submission logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Budget soumis!'),
                      backgroundColor: Color(0xFFDAAC2A),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFFDAAC2A), // Match button color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text('Soumettre'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }
}
