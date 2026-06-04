import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/sticker_provider.dart';
import '../../utils/rewards_data.dart';
import '../../core/theme/app_colors.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stickers = ref.watch(stickerProvider);

    if (stickers.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final obtained = stickers.where((s) => s.obtained).length;

    final missing = 387 - obtained;

    final progress = obtained / 387;

    int completedRewards = 0;

    for (final reward in rewards) {
      final rewardStickers = stickers.where((sticker) {
        return sticker.number >= reward.start && sticker.number <= reward.end;
      }).toList();

      final obtainedCount = rewardStickers.where((s) => s.obtained).length;

      final total = reward.end - reward.start + 1;

      if (obtainedCount == total) {
        completedRewards++;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Estadísticas 📊")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              "Resumen General",

              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary(context),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: 280,

              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 70,

                  sectionsSpace: 4,

                  sections: [
                    PieChartSectionData(
                      color: Colors.green,

                      value: obtained.toDouble(),

                      title: "${(progress * 100).toStringAsFixed(1)}%",

                      radius: 80,

                      titleStyle: TextStyle(
                        color: AppColors.textPrimary(context),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    PieChartSectionData(
                      value: missing.toDouble(),

                      title: "",

                      radius: 70,

                      color: AppColors.progressBackground(context),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            _buildInfoCard(
              context,
              title: "Figuritas obtenidas",
              value: "$obtained",
              icon: Icons.check_circle,
              color: Colors.green,
            ),

            const SizedBox(height: 16),

            _buildInfoCard(
              context,
              title: "Figuritas faltantes",
              value: "$missing",
              icon: Icons.cancel,
              color: Colors.red,
            ),

            const SizedBox(height: 16),

            _buildInfoCard(
              context,
              title: "Premios desbloqueados",
              value: "$completedRewards",
              icon: Icons.emoji_events,
              color: Colors.amber,
            ),

            const SizedBox(height: 16),

            _buildInfoCard(
              context,
              title: "Porcentaje completado",
              value: "${(progress * 100).toStringAsFixed(1)}%",
              icon: Icons.bar_chart,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Row(
          children: [
            CircleAvatar(
              radius: 28,

              backgroundColor: color.withOpacity(0.2),

              child: Icon(icon, color: color, size: 28),
            ),

            const SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    value,

                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    title,
                    style: TextStyle(color: AppColors.textSecondary(context)),
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
