import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

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

      elevation: 1,

      child: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Icon(
              icon,
              size: 30,
              color: Colors.green,
            ),

            const Spacer(),

            Text(

              value,

              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color:
                    AppColors.textPrimary(
                        context),
              ),
            ),

            const SizedBox(height: 6),

            Text(
              title,
              style: TextStyle(
                color:
                    AppColors.textSecondary(
                        context),
              ),
            ),

          ],
        ),
      ),
    );
  }
}