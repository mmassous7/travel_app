import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'results_screen.dart'; // Import the search results screen
import 'profile_screen.dart'; // Import the profile screen

void main() {
  runApp(const TravelApp());
}

class TravelOption {
  final String label;
  final IconData icon;
  TravelOption({required this.label, required this.icon});
}

class TravelApp extends StatelessWidget {
  const TravelApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFDAAC2A),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Color(0xFF5A4500),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Color(0xFFDAAC2A)),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTimeRange? _selectedDateRange;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  TravelOption? _selectedTravelType;
  TravelOption? _selectedTravelGroup;
  int _selectedIndex = 0;

  // Define theme colors as constants
  static const Color primaryLight = Color(0xFFF1F1BC);
  static const Color primaryDark = Color(0xFFDAAC2A);
  static const Color textPrimary = Color(0xFF5A4500);
  static const Color textSecondary = Color(0xFF7A6420);

  final List<TravelOption> _travelTypes = [
    TravelOption(label: 'Nature', icon: Icons.nature_people),
    TravelOption(label: 'Culture', icon: Icons.museum),
    TravelOption(label: 'Aventure', icon: Icons.explore),
  ];

  final List<TravelOption> _travelGroups = [
    TravelOption(label: 'Solo', icon: Icons.person),
    TravelOption(label: 'Couple', icon: Icons.people),
    TravelOption(label: 'Famille', icon: Icons.family_restroom),
    TravelOption(label: 'Groupe', icon: Icons.group),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to profile screen if the profile tab is tapped
    if (index == 3) {
      // Index 3 is the profile tab
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    }
  }

  // Method to navigate to profile screen
  void _navigateToProfileScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()),
    );
  }

  // Method to navigate to search results screen
  void _navigateToSearchResults() {
    // Parse budget value
    double? budget;
    if (_amountController.text.isNotEmpty) {
      budget = double.tryParse(_amountController.text);
    }

    // Navigate to results screen with search parameters
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsScreen(
          destination:
              _searchController.text.isNotEmpty ? _searchController.text : null,
          travelType: _selectedTravelType?.label,
          travelGroup: _selectedTravelGroup?.label,
          dateRange: _selectedDateRange,
          budget: budget,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [primaryLight, Color(0xFFF5F1D0)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFF1F1BC), Color(0xFFDAAC2A)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
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
                              const Icon(
                                Icons.travel_explore,
                                color: textPrimary,
                                size: 28,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'EasyTravel',
                                style: TextStyle(
                                  color: textPrimary,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                      Icons.notifications_none_rounded,
                                      color: textPrimary),
                                  onPressed: () {},
                                  iconSize: 24,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                      Icons.account_circle_outlined,
                                      color: textPrimary),
                                  onPressed: _navigateToProfileScreen,
                                  iconSize: 24,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
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
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildWelcomeHeader(),
                      const SizedBox(height: 30),
                      _buildSearchField(),
                      const SizedBox(height: 30),
                      _buildSectionHeader('Type de voyage'),
                      const SizedBox(height: 15),
                      _buildTravelTypeSelection(),
                      const SizedBox(height: 30),
                      _buildSectionHeader('Composition du voyage'),
                      const SizedBox(height: 15),
                      _buildTravelGroupSelection(),
                      const SizedBox(height: 30),
                      _buildDateRangePicker(context),
                      const SizedBox(height: 30),
                      _buildBudgetInput(),
                      const SizedBox(height: 30),
                      _buildSearchButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [primaryLight, Color(0xFFE8E4A0)],
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
                icon: Icon(Icons.favorite_border), label: 'Favoris'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: 'Profil'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: primaryDark,
          unselectedItemColor: textSecondary,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Bonjour, Voyageur!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Planifiez votre prochaine aventure',
          style: TextStyle(
            fontSize: 16,
            color: textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: TextFormField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Où souhaitez-vous aller?',
          hintStyle: const TextStyle(color: textSecondary),
          prefixIcon: const Icon(Icons.search, color: primaryDark),
          filled: true,
          fillColor: Colors.white.withOpacity(0.9),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _buildTravelTypeSelection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _travelTypes.map((option) {
          bool isSelected = _selectedTravelType == option;
          return GestureDetector(
            onTap: () {
              setState(() {
                if (isSelected) {
                  _selectedTravelType = null;
                } else {
                  _selectedTravelType = option;
                }
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: isSelected ? primaryDark : Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? primaryDark.withOpacity(0.3)
                        : Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    option.icon,
                    color: isSelected ? Colors.white : textSecondary,
                    size: 24,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    option.label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : textSecondary,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTravelGroupSelection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _travelGroups.map((option) {
          bool isSelected = _selectedTravelGroup == option;
          return GestureDetector(
            onTap: () {
              setState(() {
                if (isSelected) {
                  _selectedTravelGroup = null;
                } else {
                  _selectedTravelGroup = option;
                }
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: isSelected ? primaryDark : Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? primaryDark.withOpacity(0.3)
                        : Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    option.icon,
                    color: isSelected ? Colors.white : textSecondary,
                    size: 24,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    option.label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : textSecondary,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDateRangePicker(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTimeRange? picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                  primary: primaryDark,
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) setState(() => _selectedDateRange = picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, color: primaryDark),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                _selectedDateRange == null
                    ? 'Sélectionner vos dates'
                    : '${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.start)} - ${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.end)}',
                style: TextStyle(
                  fontSize: 16,
                  color:
                      _selectedDateRange == null ? textSecondary : textPrimary,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                color: textSecondary.withOpacity(0.7), size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetInput() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: TextFormField(
        controller: _amountController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Budget maximal (€)',
          labelStyle: const TextStyle(color: textSecondary),
          prefixIcon: const Icon(Icons.euro, color: primaryDark),
          filled: true,
          fillColor: Colors.white.withOpacity(0.9),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: primaryDark.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          )
        ],
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryDark, Color(0xFFE8A526)],
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          // Show confirmation
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Recherche en cours...'),
              backgroundColor: primaryDark,
              duration: Duration(seconds: 1),
            ),
          );

          // Log search parameters
          print('Destination: ${_searchController.text}');
          print('Type de voyage: ${_selectedTravelType?.label}');
          print('Composition du voyage: ${_selectedTravelGroup?.label}');
          print(
              'Période: ${_selectedDateRange?.start} - ${_selectedDateRange?.end}');
          print('Budget: ${_amountController.text}');

          // Navigate to search results screen
          _navigateToSearchResults();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: const Text(
          'Rechercher',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
