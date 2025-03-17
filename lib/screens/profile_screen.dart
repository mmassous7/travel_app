import 'package:flutter/material.dart';
import 'home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;
  bool _notificationsEnabled = true;
  bool _locationEnabled = false;

  // Controllers for text fields
  final TextEditingController _nameController =
      TextEditingController(text: "Jean Dupont");
  final TextEditingController _emailController =
      TextEditingController(text: "jean.dupont@example.com");
  final TextEditingController _phoneController =
      TextEditingController(text: "+33 6 12 34 56 78");
  final TextEditingController _locationController =
      TextEditingController(text: "Paris, France");

  // Define theme colors as constants
  static const Color primaryLight = Color(0xFFF1F1BC);
  static const Color primaryDark = Color(0xFFDAAC2A);
  static const Color textPrimary = Color(0xFF5A4500);
  static const Color textSecondary = Color(0xFF7A6420);
  static const Color backgroundLight = Color(0xFFF8F8E0);

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
                      const Text(
                        'Mon Profil',
                        style: TextStyle(
                          color: textPrimary,
                          fontSize: 22,
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
                        _isEditing ? Icons.check : Icons.edit_outlined,
                        color: textPrimary,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_isEditing) {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Profil mis à jour'),
                                  backgroundColor: primaryDark,
                                ),
                              );
                            }
                          }
                          _isEditing = !_isEditing;
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildProfileHeader(),
                  const SizedBox(height: 24),
                  _buildPersonalInfoSection(),
                  const SizedBox(height: 24),
                  _buildPreferencesSection(),
                  const SizedBox(height: 24),
                  _buildAccountActionsSection(),
                ],
              ),
            ),
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
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
          currentIndex: 3, // Profile tab selected
          selectedItemColor: primaryDark,
          unselectedItemColor: textSecondary,
          onTap: (index) {
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
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
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: primaryLight,
                backgroundImage: const NetworkImage(
                    "https://placehold.co/100"), // Placeholder avatar
                child: const Text(
                  "JD",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
              ),
              if (_isEditing)
                Container(
                  decoration: BoxDecoration(
                    color: primaryDark,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt,
                        color: Colors.white, size: 18),
                    onPressed: () {
                      // Trigger image selection
                    },
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          _isEditing
              ? TextFormField(
                  controller: _nameController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Votre nom',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre nom';
                    }
                    return null;
                  },
                )
              : Text(
                  _nameController.text,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
          const SizedBox(height: 8),
          const Text(
            'Membre depuis Janvier 2023',
            style: TextStyle(color: textSecondary, fontSize: 14),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStatItem('5', 'Voyages'),
              Container(
                height: 40,
                width: 1,
                color: Colors.grey.withOpacity(0.3),
                margin: const EdgeInsets.symmetric(horizontal: 15),
              ),
              _buildStatItem('3', 'Pays'),
              Container(
                height: 40,
                width: 1,
                color: Colors.grey.withOpacity(0.3),
                margin: const EdgeInsets.symmetric(horizontal: 15),
              ),
              _buildStatItem('12', 'Avis'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryDark,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalInfoSection() {
    return Container(
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
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.person_outline,
                color: primaryDark,
                size: 22,
              ),
              const SizedBox(width: 10),
              const Text(
                'Informations personnelles',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildProfileField(
            enabled: _isEditing,
            controller: _emailController,
            label: 'Email',
            icon: Icons.email_outlined,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre email';
              }
              final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
              if (!emailRegex.hasMatch(value)) {
                return 'Veuillez entrer un email valide';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildProfileField(
            enabled: _isEditing,
            controller: _phoneController,
            label: 'Téléphone',
            icon: Icons.phone_outlined,
          ),
          const SizedBox(height: 16),
          _buildProfileField(
            enabled: _isEditing,
            controller: _locationController,
            label: 'Localisation',
            icon: Icons.location_on_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection() {
    return Container(
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
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.settings_outlined,
                color: primaryDark,
                size: 22,
              ),
              const SizedBox(width: 10),
              const Text(
                'Préférences',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildToggleOption(
            'Notifications',
            _notificationsEnabled,
            (value) {
              if (_isEditing) {
                setState(() {
                  _notificationsEnabled = value;
                });
              }
            },
            Icons.notifications_outlined,
          ),
          const Divider(height: 24, thickness: 1, color: Color(0xFFEEEAD0)),
          _buildToggleOption(
            'Services de localisation',
            _locationEnabled,
            (value) {
              if (_isEditing) {
                setState(() {
                  _locationEnabled = value;
                });
              }
            },
            Icons.location_on_outlined,
          ),
          const Divider(height: 24, thickness: 1, color: Color(0xFFEEEAD0)),
          _buildToggleOption(
            'Mode sombre',
            false,
            (value) {
              // Theme switching logic would go here
            },
            Icons.dark_mode_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountActionsSection() {
    return Container(
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
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.admin_panel_settings_outlined,
                color: primaryDark,
                size: 22,
              ),
              const SizedBox(width: 10),
              const Text(
                'Compte',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildActionButton(
            'Changer le mot de passe',
            Icons.lock_outline,
            () {
              // Navigate to password change screen
            },
          ),
          const SizedBox(height: 12),
          _buildActionButton('Aide et support', Icons.help_outline, () {
            // Navigate to help screen
          }),
          const SizedBox(height: 12),
          _buildActionButton(
            'Se déconnecter',
            Icons.logout,
            () {
              // Logout logic - would be handled by backend
              // Navigate to login screen
            },
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool enabled = true,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      validator: validator,
      style: const TextStyle(color: textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: textSecondary),
        prefixIcon: Icon(icon, color: primaryDark),
        filled: true,
        fillColor: const Color(0xFFF5F5E5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: primaryDark, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }

  Widget _buildToggleOption(
    String title,
    bool value,
    Function(bool) onChanged,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: primaryDark, size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: textPrimary,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: primaryDark,
            activeTrackColor: primaryLight,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    VoidCallback onPressed, {
    bool isDestructive = false,
  }) {
    final Color textColor = isDestructive ? Colors.red.shade700 : textPrimary;
    final Color iconColor = isDestructive ? Colors.red.shade700 : primaryDark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDestructive ? Colors.red.shade50 : const Color(0xFFF5F5E5),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isDestructive ? Colors.red.shade200 : const Color(0xFFEEEAD0),
          width: 1,
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(icon, color: iconColor),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right,
              color: textColor.withOpacity(0.5),
              size: 20,
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}
