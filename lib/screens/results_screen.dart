import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SearchResultsScreen extends StatefulWidget {
  final String? destination;
  final String? travelType;
  final String? travelGroup;
  final DateTimeRange? dateRange;
  final double? budget;

  const SearchResultsScreen({
    Key? key,
    this.destination,
    this.travelType,
    this.travelGroup,
    this.dateRange,
    this.budget,
  }) : super(key: key);

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  // Define theme colors as constants
  static const Color primaryLight = Color(0xFFF1F1BC);
  static const Color primaryDark = Color(0xFFDAAC2A);
  static const Color textPrimary = Color(0xFF5A4500);
  static const Color textSecondary = Color(0xFF7A6420);
  static const Color backgroundLight = Color(0xFFF8F8E0);

  String _sortBy = 'recommended'; // Default sort option
  bool _isFilterVisible = false;
  RangeValues _priceRange = const RangeValues(0, 5000);
  double _minRating = 3.0;

  // Mock travel options that would be returned from an API
  final List<TravelDestination> _destinations = [
    TravelDestination(
      name: 'Les Calanques de Marseille',
      location: 'Marseille, France',
      description:
          'Découvrez les magnifiques calanques et leurs eaux turquoises. Parfait pour la randonnée et la baignade.',
      price: 780,
      rating: 4.7,
      imageUrl: 'assets/images/calanques.jpg',
      tags: ['Nature', 'Aventure'],
      duration: 5,
    ),
    TravelDestination(
      name: 'Mont Saint-Michel',
      location: 'Normandie, France',
      description:
          'Visitez cette île majestueuse avec son abbaye médiévale. Une merveille architecturale à ne pas manquer.',
      price: 950,
      rating: 4.9,
      imageUrl: 'assets/images/mont_saint_michel.jpg',
      tags: ['Culture', 'Histoire'],
      duration: 3,
    ),
    TravelDestination(
      name: 'Gorges du Verdon',
      location: 'Provence, France',
      description:
          'Le plus grand canyon d\'Europe. Idéal pour le canoë, le rafting et l\'escalade.',
      price: 620,
      rating: 4.5,
      imageUrl: 'assets/images/verdon.jpg',
      tags: ['Nature', 'Aventure'],
      duration: 4,
    ),
    TravelDestination(
      name: 'Alpes Françaises',
      location: 'Chamonix, France',
      description:
          'Profitez des paysages alpins époustouflants et des activités de montagne en toute saison.',
      price: 1200,
      rating: 4.6,
      imageUrl: 'assets/images/alpes.jpg',
      tags: ['Nature', 'Aventure'],
      duration: 7,
    ),
    TravelDestination(
      name: 'Musée du Louvre',
      location: 'Paris, France',
      description:
          'Le plus grand musée d\'art et d\'antiquités au monde. Découvrez des milliers d\'œuvres d\'art.',
      price: 850,
      rating: 4.8,
      imageUrl: 'assets/images/louvre.jpg',
      tags: ['Culture', 'Art'],
      duration: 4,
    ),
  ];

  List<TravelDestination> _filteredDestinations = [];

  @override
  void initState() {
    super.initState();
    // Initial filtering based on search criteria
    _applyFilters();
  }

  void _applyFilters() {
    setState(() {
      _filteredDestinations = _destinations.where((destination) {
        // Filter by price range
        if (destination.price < _priceRange.start ||
            destination.price > _priceRange.end) {
          return false;
        }

        // Filter by rating
        if (destination.rating < _minRating) {
          return false;
        }

        // Filter by travel type if selected
        if (widget.travelType != null &&
            !destination.tags.contains(widget.travelType)) {
          return false;
        }

        // Filter by budget if provided
        if (widget.budget != null && destination.price > widget.budget!) {
          return false;
        }

        // Add more filters as needed (for amenities, etc.)

        return true;
      }).toList();

      // Apply sorting
      _sortDestinations();
    });
  }

  void _sortDestinations() {
    switch (_sortBy) {
      case 'price_low':
        _filteredDestinations.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_high':
        _filteredDestinations.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'rating':
        _filteredDestinations.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'duration':
        _filteredDestinations.sort((a, b) => a.duration.compareTo(b.duration));
        break;
      case 'recommended':
      default:
        // For recommended, we might use a combination of factors
        _filteredDestinations.sort((a, b) => (b.rating * 100 - b.price / 100)
            .compareTo(a.rating * 100 - a.price / 100));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
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
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: textPrimary,
                          size: 22,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Résultats de recherche',
                        style: TextStyle(
                          color: textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: Icon(
                        _isFilterVisible
                            ? Icons.filter_list_off
                            : Icons.filter_list,
                        color: textPrimary,
                      ),
                      onPressed: () {
                        setState(() {
                          _isFilterVisible = !_isFilterVisible;
                        });
                      },
                      iconSize: 24,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
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
            colors: [primaryLight, Color(0xFFF5F1D0)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Search summary section
              _buildSearchSummary(),

              // Filter section (expandable)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _isFilterVisible ? 280 : 0,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: _buildFilterSection(),
                ),
              ),

              // Results count and sort options
              _buildResultsHeader(),

              // List of destinations
              Expanded(
                child: _filteredDestinations.isEmpty
                    ? _buildNoResultsMessage()
                    : _buildDestinationsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchSummary() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.destination ?? 'Toutes destinations',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildSummaryItem(
                  Icons.category, widget.travelType ?? 'Tous types'),
              _buildSummaryItem(
                  Icons.people, widget.travelGroup ?? 'Tous groupes'),
              _buildSummaryItem(
                Icons.calendar_today,
                widget.dateRange != null
                    ? '${DateFormat('dd/MM').format(widget.dateRange!.start)} - ${DateFormat('dd/MM').format(widget.dateRange!.end)}'
                    : 'Toutes dates',
              ),
              _buildSummaryItem(
                Icons.euro,
                widget.budget != null
                    ? '≤ ${widget.budget!.toInt()}€'
                    : 'Tous budgets',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(IconData icon, String text) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 16, color: primaryDark),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: textSecondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Price range slider
          const Text(
            'Budget',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          RangeSlider(
            values: _priceRange,
            min: 0,
            max: 5000,
            divisions: 50,
            activeColor: primaryDark,
            inactiveColor: primaryLight,
            labels: RangeLabels(
              '${_priceRange.start.round()}€',
              '${_priceRange.end.round()}€',
            ),
            onChanged: (values) {
              setState(() {
                _priceRange = values;
              });
            },
          ),
          Text(
            'Prix: ${_priceRange.start.round()}€ - ${_priceRange.end.round()}€',
            style: const TextStyle(
              fontSize: 14,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: 16),

          // Minimum rating
          const Text(
            'Évaluation minimum',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              RatingBar.builder(
                initialRating: _minRating,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 24,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: primaryDark,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _minRating = rating;
                  });
                },
              ),
              const SizedBox(width: 8),
              Text(
                _minRating.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  color: textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Apply filters button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _applyFilters();
                setState(() {
                  _isFilterVisible = false;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryDark,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Appliquer les filtres',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${_filteredDestinations.length} résultats trouvés',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: primaryLight),
            ),
            child: DropdownButton<String>(
              value: _sortBy,
              icon: const Icon(Icons.keyboard_arrow_down, color: primaryDark),
              underline: const SizedBox(),
              style: const TextStyle(color: textPrimary, fontSize: 14),
              isDense: true,
              onChanged: (String? newValue) {
                setState(() {
                  _sortBy = newValue!;
                  _sortDestinations();
                });
              },
              items: <String>[
                'recommended',
                'price_low',
                'price_high',
                'rating',
                'duration',
              ].map<DropdownMenuItem<String>>((String value) {
                String label;
                switch (value) {
                  case 'price_low':
                    label = 'Prix: croissant';
                    break;
                  case 'price_high':
                    label = 'Prix: décroissant';
                    break;
                  case 'rating':
                    label = 'Meilleures notes';
                    break;
                  case 'duration':
                    label = 'Durée: plus courte';
                    break;
                  case 'recommended':
                  default:
                    label = 'Recommandés';
                    break;
                }
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(label),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResultsMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: primaryDark.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'Aucun résultat trouvé',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Essayez de modifier vos filtres ou vos critères de recherche',
            style: TextStyle(
              fontSize: 14,
              color: textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryDark,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Nouvelle recherche'),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: _filteredDestinations.length,
      itemBuilder: (context, index) {
        final destination = _filteredDestinations[index];
        return _buildDestinationCard(destination);
      },
    );
  }

  Widget _buildDestinationCard(TravelDestination destination) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // Navigate to detail page
          print('Navigate to detail for: ${destination.name}');
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Destination image with overlay
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/${destination.imageUrl}'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Gradient overlay for better text readability
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),

                  // Price and duration badge
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${destination.price}€ • ${destination.duration} jours',
                        style: const TextStyle(
                          color: textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),

                  // Favorite button
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite_border,
                        color: primaryDark,
                        size: 20,
                      ),
                    ),
                  ),

                  // Location text at bottom of image
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          destination.location,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          destination.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textPrimary,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: primaryDark,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            destination.rating.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Description
                  Text(
                    destination.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 12),

                  // Tags
                  Row(
                    children: destination.tags.map((tag) {
                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: primaryLight.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            fontSize: 12,
                            color: textPrimary,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 16),

                  // Details button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to detail page
                        print('Navigate to detail for: ${destination.name}');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryDark,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Voir les détails',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Model class for travel destinations
class TravelDestination {
  final String name;
  final String location;
  final String description;
  final double price;
  final double rating;
  final String imageUrl;
  final List<String> tags;
  final int duration; // in days

  TravelDestination({
    required this.name,
    required this.location,
    required this.description,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.tags,
    required this.duration,
  });
}
