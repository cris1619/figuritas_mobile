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
            const SizedBox(height: 30),

            Text(

              "Progreso por Premios",

              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary(context),
              ),
            ),

            const SizedBox(height: 20),

            ...rewards.map((reward) {

              final rewardStickers =
                  stickers.where((sticker) {

                return sticker.number >= reward.start &&
                    sticker.number <= reward.end;

              }).toList();

              final obtainedCount =
                  rewardStickers
                      .where((s) => s.obtained)
                      .length;

              final total =
                  reward.end - reward.start + 1;

              final progress =
                  obtainedCount / total;

              return Padding(

                padding: const EdgeInsets.only(bottom: 16),

                child: Card(

                  child: Padding(

                    padding: const EdgeInsets.all(18),

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Row(

                          children: [

                            Expanded(

                              child: Text(

                                reward.name,

                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight.bold,
                                  color:
                                      AppColors
                                          .textPrimary(
                                              context),
                                ),
                              ),
                            ),

                            Text(

                              "$obtainedCount/$total",

                              style: TextStyle(
                                color:
                                    AppColors
                                        .textSecondary(
                                            context),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        ClipRRect(

                          borderRadius:
                              BorderRadius.circular(20),

                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 12,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(

                          "${(progress * 100).toStringAsFixed(1)}% completado",

                          style: TextStyle(
                            color:
                                AppColors.textMuted(
                                    context),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 30),

            Builder(

              builder: (_) {

                String nearestReward = '';

                double bestProgress = 0;

                for (final reward in rewards) {

                  final rewardStickers =
                      stickers.where((sticker) {

                    return sticker.number >= reward.start &&
                        sticker.number <= reward.end;

                  }).toList();

                  final obtainedCount =
                      rewardStickers
                          .where((s) => s.obtained)
                          .length;

                  final total =
                      reward.end - reward.start + 1;

                  final progress =
                      obtainedCount / total;

                  if (progress > bestProgress &&
                      progress < 1) {

                    bestProgress = progress;

                    nearestReward = reward.name;
                  }
                }

                return Card(

                  child: Padding(

                    padding: const EdgeInsets.all(20),

                    child: Row(

                      children: [

                        const Icon(
                          Icons.local_fire_department,
                          color: Colors.orange,
                          size: 40,
                        ),

                        const SizedBox(width: 20),

                        Expanded(

                          child: Column(

                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [

                              Text(

                                "Premio más cercano",

                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      AppColors
                                          .textSecondary(
                                              context),
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(

                                completedRewards == rewards.length
                              ? "Todos completados 🔥"
                              : nearestReward.isEmpty
                                  ? "Sin progreso aún"
                                  : nearestReward,

                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight:
                                      FontWeight.bold,
                                  color:
                                      AppColors
                                          .textPrimary(
                                              context),
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(

                                completedRewards == rewards.length

                                ? "Álbum finalizado"

                                : nearestReward.isEmpty

                                    ? "Empieza a coleccionar figuritas"

                                    : "${(bestProgress * 100).toStringAsFixed(1)}% completado",

                                style: TextStyle(
                                  color:
                                      AppColors
                                          .textMuted(
                                              context),
                                ),
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              },
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

              backgroundColor: color.withAlpha((0.2 * 255).round()),

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
