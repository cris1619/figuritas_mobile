import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/sticker_provider.dart';
import '../../utils/rewards_data.dart';
import '../../widgets/stat_card.dart';

class DashboardScreen extends ConsumerWidget {

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final stickers = ref.watch(stickerProvider);

    if (stickers.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final obtained =
        stickers.where((s) => s.obtained).length;

    final missing = 387 - obtained;

    final progress = obtained / 387;

    int unlockedRewards = 0;

    for (final reward in rewards) {

      final rewardStickers = stickers.where((sticker) {

        return sticker.number >= reward.start &&
            sticker.number <= reward.end;

      }).toList();

      final obtainedCount = rewardStickers
          .where((s) => s.obtained)
          .length;

      final total =
          reward.end - reward.start + 1;

      if (obtainedCount == total) {
        unlockedRewards++;
      }
    }

    return Scaffold(

      appBar: AppBar(
        title: const Text("Álbum Mundial ⚽"),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(

              "Mi Progreso",

              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ClipRRect(

              borderRadius: BorderRadius.circular(20),

              child: LinearProgressIndicator(
                value: progress,
                minHeight: 18,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "${(progress * 100).toStringAsFixed(1)}% completado",
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            GridView.count(

              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              crossAxisCount:
                  _getCrossAxisCount(context),

              crossAxisSpacing: 16,
              mainAxisSpacing: 16,

              childAspectRatio: 1.4,

              children: [

                StatCard(
                  title: "Obtenidas",
                  value: "$obtained",
                  icon: Icons.check_circle,
                ),

                StatCard(
                  title: "Faltantes",
                  value: "$missing",
                  icon: Icons.cancel,
                ),

                StatCard(
                  title: "Premios",
                  value: "$unlockedRewards",
                  icon: Icons.emoji_events,
                ),

                StatCard(
                  title: "Total",
                  value: "387",
                  icon: Icons.grid_view,
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    if (width < 700) {
      return 2;
    } else {
      return 4;
    }
  }
}