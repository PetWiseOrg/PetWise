import 'package:flutter/material.dart';

class VetBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const VetBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color.fromARGB(255, 232, 222, 248),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomBarItem(
            icon: Icons.home_outlined,
            label: 'Home',
            index: 0,
          ),
          _buildBottomBarItem(
            icon: Icons.bookmark_border_rounded,
            label: 'Clinic',
            index: 1,
          ),
          _buildBottomBarItem(
            icon: Icons.notifications_none,
            label: 'Updates',
            index: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBarItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: isSelected
                  ? BoxDecoration(
                      color: const Color.fromARGB(255, 204, 194, 220),
                      borderRadius: BorderRadius.circular(30), // More oval shape
                    )
                  : null,
              child: Icon(icon, color: Colors.black),
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}