import 'package:flutter/material.dart';

class ProfileSelectionScreen extends StatelessWidget {
  final String userName;

  const ProfileSelectionScreen({
    super.key,
    this.userName = "Fulano de tal",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF65B6FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF65B6FB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // User profile header
          _buildProfileHeader(),

          // Main content
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    "Qual perfil você\nquer administrar?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF65B6FB),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Grid of profile options
                  _buildProfileGrid(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      color: const Color(0xFF65B6FB),
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Row(
        children: [
          // User avatar
          Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              color: Color(0xFFD3D3D3),
              shape: BoxShape.circle,
            ),
            child: Stack(
              children: [
                // User placeholder
                const Center(
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                // Small tie icon to mimic the original
                const Positioned(
                  bottom: 15,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Icon(
                      Icons.line_weight,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Blue circle with plus sign
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        size: 18,
                        color: Color(0xFF65B6FB),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          // User name
          Text(
            userName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileGrid() {
    return Expanded(
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        shrinkWrap: true,
        children: [
          // ATLETA (active)
          _buildProfileCard(
            title: "ATLETA",
            icon: "athlete",
            isActive: true,
            onTap: () {},
          ),

          // ALUNO (inactive)
          _buildProfileCard(
            title: "ALUNO",
            icon: "student",
            isActive: false,
            onTap: () {},
          ),

          // PROFESSOR (inactive)
          _buildProfileCard(
            title: "PROFESSOR",
            icon: "teacher",
            isActive: false,
            onTap: () {},
          ),

          // ARENA (active)
          _buildProfileCard(
            title: "ARENA",
            icon: "arena",
            isActive: true,
            onTap: () {},
          ),

          // PROFISSIONAL TÉCNICO (active)
          _buildProfileCard(
            title: "PROFISSIONAL\nTÉCNICO",
            icon: "technician",
            isActive: true,
            onTap: () {},
            isCentered: true,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard({
    required String title,
    required String icon,
    required bool isActive,
    required VoidCallback onTap,
    bool isCentered = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF65B6FB) : const Color(0xFFD3D3D3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getIconForProfile(icon, isActive),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: isCentered ? 14 : 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getIconForProfile(String iconName, bool isActive) {
    // Using custom icon implementation instead of SVG for simplicity
    IconData iconData;
    switch (iconName) {
      case "athlete":
        iconData = Icons.sports_gymnastics;
        break;
      case "student":
        iconData = Icons.school;
        break;
      case "teacher":
        iconData = Icons.present_to_all;
        break;
      case "arena":
        iconData = Icons.stadium;
        break;
      case "technician":
        iconData = Icons.edit_document;
        break;
      default:
        iconData = Icons.person;
    }

    return Icon(
      iconData,
      size: 40,
      color: Colors.white,
    );
  }
}

// Custom SVG icons for each profile type
class ProfileIcons {
  static String get athlete => '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="white">
  <path d="M12,2C9.38,2 7.125,3.7 6.25,6L2,6v2h4.25c0.875,2.3 3.13,4 5.75,4s4.875,-1.7 5.75,-4L22,8L22,6h-4.25C16.875,3.7 14.62,2 12,2zM16,11.75L16,16h2v2h-2v2h-2v-2L8,18v-2h6v-4.25C15.375,11.5 15.75,11.375 16,11.75z"/>
</svg>
  ''';

  static String get student => '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="white">
  <path d="M12,2A10,10 0 0,0 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12A10,10 0 0,0 12,2M12,8.39C13.57,9.4 15.42,10 17.42,10C18.2,10 18.95,9.91 19.67,9.74C19.88,10.45 20,11.21 20,12C20,16.41 16.41,20 12,20C9,20 6.39,18.34 5,15.89L6.75,14V13A1.25,1.25 0 0,1 8,11.75A1.25,1.25 0 0,1 9.25,13V14H12M8.82,3.88C9.18,3.34 10.24,2.42 12.82,5.31C14.84,7.14 16.14,5.73 16.92,5.33C18.37,6.94 19.16,9.05 19.07,11.36C17.82,11.85 16.36,12 15,12V13H9V12C7.24,12 6,10.76 6,9H4.18C4.17,8.67 4.25,8.21 4.22,7.76C5,7.74 6,7.86 7,8.12C7.28,6.85 7.87,5.23 8.82,3.88M9.5,4C8.57,4 7.8,4.77 7.8,5.7C7.8,6.63 8.57,7.4 9.5,7.4C10.43,7.4 11.2,6.63 11.2,5.7C11.2,4.77 10.43,4 9.5,4Z"/>
</svg>
  ''';

  static String get teacher => '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="white">
  <path d="M20,17A2,2 0 0,0 22,15V4A2,2 0 0,0 20,2H9.46C9.81,2.61 10,3.3 10,4H20V15H11V17M15,7V9H9V22H7V16H5V22H3V14H1.5V9A2,2 0 0,1 3.5,7H15M8,4A2,2 0 0,1 6,6A2,2 0 0,1 4,4A2,2 0 0,1 6,2A2,2 0 0,1 8,4Z"/>
</svg>
  ''';

  static String get arena => '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="white">
  <path d="M12,2L2,9V22H22V9L12,2M18,19H13V16H11V19H6V11L12,7L18,11V19Z"/>
</svg>
  ''';

  static String get technician => '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="white">
  <path d="M21.04 12.13C21.18 12.13 21.31 12.19 21.42 12.3L22.7 13.58C22.92 13.79 22.92 14.14 22.7 14.35L21.7 15.35L19.65 13.3L20.65 12.3C20.76 12.19 20.9 12.13 21.04 12.13M19.07 13.88L21.12 15.93L15.06 22H13V19.94L19.07 13.88M11 19L9 21H5C3.9 21 3 20.1 3 19V5C3 3.9 3.9 3 5 3H9.18C9.6 1.84 10.7 1 12 1C13.3 1 14.4 1.84 14.82 3H19C20.1 3 21 3.9 21 5V9L19 11V5H17V7H7V5H5V19H11M12 3C11.45 3 11 3.45 11 4C11 4.55 11.45 5 12 5C12.55 5 13 4.55 13 4C13 3.45 12.55 3 12 3Z"/>
</svg>
  ''';
}
