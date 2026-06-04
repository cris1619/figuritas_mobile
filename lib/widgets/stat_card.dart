import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {

  final String title;
  final String value;
  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      child: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Icon(
              icon,
              size: 32,
              color: Colors.greenAccent,
            ),

            const SizedBox(height: 20),

            Text(

              value,

              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),

          ],
        ),
      ),
    );
  }
}