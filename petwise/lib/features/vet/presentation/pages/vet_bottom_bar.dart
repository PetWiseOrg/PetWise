import 'package:flutter/material.dart';

class VetBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const VetBottomBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

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
    //TODO make it so only the selected icon changes color
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        decoration: isSelected
            ? BoxDecoration(
                color: const Color.fromARGB(255, 204, 194, 220),
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color:Colors.black),
            Text(
              label,
              style: const TextStyle(color:Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}