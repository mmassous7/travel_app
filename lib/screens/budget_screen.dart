import 'package:flutter/material.dart';
import 'dart:math';
import 'en_cours_screen.dart';

class BudgetScreen extends StatelessWidget {
  final double estimatedBudget;

  const BudgetScreen({Key? key, required this.estimatedBudget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double activitiesBudget = estimatedBudget * 0.5;
    double accommodationBudget = estimatedBudget * 0.3;
    double mealsBudget = estimatedBudget * 0.2;

    double total = activitiesBudget + accommodationBudget + mealsBudget;
    double activitiesPercentage = (activitiesBudget / total) * 100;
    double accommodationPercentage = (accommodationBudget / total) * 100;
    double mealsPercentage = (mealsBudget / total) * 100;

    return Scaffold(
      backgroundColor: const Color(0xFFEAEAEA), // Match background color
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
                        'Budget Estimé',
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Votre budget estimé',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5A4500),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: CustomPaint(
                    painter: BudgetPainter(
                      activitiesBudget: activitiesBudget,
                      accommodationBudget: accommodationBudget,
                      mealsBudget: mealsBudget,
                      activitiesPercentage: activitiesPercentage,
                      accommodationPercentage: accommodationPercentage,
                      mealsPercentage: mealsPercentage,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegend(
                      'Activités', Colors.blueAccent, activitiesPercentage),
                  _buildLegend('Hébergement', Colors.lightGreen,
                      accommodationPercentage),
                  _buildLegend(
                      'Repas', Colors.deepOrangeAccent, mealsPercentage),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDAAC2A),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Retour aux Activités',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to EnCoursScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EnCoursScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDAAC2A),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Terminer',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegend(String category, Color color, double percentage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(
          '$category: ${percentage.toStringAsFixed(1)}%',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class BudgetPainter extends CustomPainter {
  final double activitiesBudget;
  final double accommodationBudget;
  final double mealsBudget;
  final double activitiesPercentage;
  final double accommodationPercentage;
  final double mealsPercentage;

  BudgetPainter({
    required this.activitiesBudget,
    required this.accommodationBudget,
    required this.mealsBudget,
    required this.activitiesPercentage,
    required this.accommodationPercentage,
    required this.mealsPercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double total = activitiesBudget + accommodationBudget + mealsBudget;
    double activitiesAngle = (activitiesBudget / total) * 2 * pi;
    double accommodationAngle = (accommodationBudget / total) * 2 * pi;
    double mealsAngle = (mealsBudget / total) * 2 * pi;

    Paint paint = Paint()..style = PaintingStyle.fill;

    // Draw Activities
    paint.color = Colors.blueAccent;
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: size.width / 2),
        0,
        activitiesAngle,
        true,
        paint);

    // Draw Accommodation
    paint.color = Colors.lightGreen;
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: size.width / 2),
        activitiesAngle,
        accommodationAngle,
        true,
        paint);

    // Draw Meals
    paint.color = Colors.deepOrangeAccent;
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: size.width / 2),
        activitiesAngle + accommodationAngle,
        mealsAngle,
        true,
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
