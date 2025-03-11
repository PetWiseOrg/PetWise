import 'package:flutter/material.dart';
import 'package:petwise/navigation/routing.dart';
import 'package:go_router/go_router.dart';

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
            context: context,
          ),
          _buildBottomBarItem(
            icon: Icons.bookmark_border_rounded,
            label: 'Clinic',
            index: 1,
            context: context,
          ),
          _buildBottomBarItem(
            icon: Icons.calendar_month,
            label: 'Calendar',
            index: 2,
            context: context,
          ),
        ],
      ),
    );
  }

  void goToClinicPage(BuildContext context) {
    context.goNamed(AppRoute.vetClinicPage.name);
  }

  void goToDashboardPage(BuildContext context) {
    context.goNamed(AppRoute.vetDashboardPage.name);
  }

  void goToCalendarPage(BuildContext context) {
    context.goNamed(AppRoute.vetCalendarPage.name);
  }

  Widget _buildBottomBarItem({
    required IconData icon,
    required String label,
    required int index,
    required BuildContext context,
  }) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        if (index == 0) {
          goToDashboardPage(context);
        } else if (index == 1) {
          goToClinicPage(context);
        } else if (index == 2) {
          goToCalendarPage(context);
        }
        onItemTapped(index);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: isSelected
                  ? BoxDecoration(
                      color: const Color.fromARGB(255, 204, 194, 220),
                      borderRadius: BorderRadius.circular(30), 
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