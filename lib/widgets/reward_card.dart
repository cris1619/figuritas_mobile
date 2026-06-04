import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class RewardCard extends StatelessWidget {
  final String title;
  final int obtained;
  final int total;

  const RewardCard({
    super.key,
    required this.title,
    required this.obtained,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final progress = obtained / total;

    final completed = obtained == total;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Icon(
                  completed ? Icons.emoji_events : Icons.lock_open,

                  color: completed
                      ? Colors.amber
                      : AppColors.iconColor(context),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    title,

                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),

              child: LinearProgressIndicator(value: progress, minHeight: 14),
            ),

            const SizedBox(height: 10),

            Text(
              "$obtained / $total figuritas",
              style: TextStyle(color: AppColors.textSecondary(context)),
            ),

            const SizedBox(height: 6),

            Text(
              "${(progress * 100).toStringAsFixed(1)}% completado",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
