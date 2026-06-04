import 'package:flutter/material.dart';

import '../screens/dashboard/dashboard_screen.dart';
import '../screens/rewards/rewards_screen.dart';
import '../screens/stats/stats_screen.dart';
import '../screens/stickers/stickers_screen.dart';
import '../core/responsive/responsive.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {

  int currentIndex = 0;

  final List<Widget> pages = [
    const DashboardScreen(),
    const StickersScreen(),
    const RewardsScreen(),
    const StatsScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

  body: pages[currentIndex],

  bottomNavigationBar:

      Responsive.isDesktop(context)

          ? null

          : NavigationBar(

              selectedIndex: currentIndex,

              onDestinationSelected:
                  (index) {

                setState(() {
                  currentIndex = index;
                });
              },

              destinations: const [

                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Inicio',
                ),

                NavigationDestination(
                  icon:
                      Icon(Icons.grid_view_outlined),
                  selectedIcon:
                      Icon(Icons.grid_view),
                  label: 'Figuritas',
                ),

                NavigationDestination(
                  icon: Icon(
                      Icons.card_giftcard_outlined),
                  selectedIcon:
                      Icon(Icons.card_giftcard),
                  label: 'Premios',
                ),

                NavigationDestination(
                  icon:
                      Icon(Icons.bar_chart_outlined),
                  selectedIcon:
                      Icon(Icons.bar_chart),
                  label: 'Stats',
                ),
              ],
            ),

  drawer:

      Responsive.isDesktop(context)

          ? Drawer(

              child: ListView(

                children: [

                  const DrawerHeader(
                    child: Text(
                      "Álbum Mundial ⚽",
                    ),
                  ),

                  _buildDrawerItem(
                    icon: Icons.home,
                    index: 0,
                    label: "Inicio",
                  ),

                  _buildDrawerItem(
                    icon: Icons.grid_view,
                    index: 1,
                    label: "Figuritas",
                  ),

                  _buildDrawerItem(
                    icon: Icons.card_giftcard,
                    index: 2,
                    label: "Premios",
                  ),

                  _buildDrawerItem(
                    icon: Icons.bar_chart,
                    index: 3,
                    label: "Stats",
                  ),

                ],
              ),
            )

          : null,
);
  }
  Widget _buildDrawerItem({
  required IconData icon,
  required int index,
  required String label,
}) {

  return ListTile(

    leading: Icon(icon),

    title: Text(label),

    selected: currentIndex == index,

    onTap: () {

      setState(() {
        currentIndex = index;
      });

      Navigator.pop(context);
    },
  );
}
}