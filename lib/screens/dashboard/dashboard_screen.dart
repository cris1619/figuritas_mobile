import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/sticker_provider.dart';
import '../../utils/rewards_data.dart';
import '../../widgets/stat_card.dart';
import '../../providers/theme_provider.dart';
import '../../core/responsive/responsive.dart';
import '../../core/theme/app_colors.dart';

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

    title: const Text("Álbum Mundial Figuritas ⚽"),

    actions: [

    IconButton(

      onPressed: () {

        ref
            .read(themeProvider.notifier)
            .toggleTheme();

      },

      icon: Icon(

        Theme.of(context).brightness ==
                Brightness.dark

            ? Icons.light_mode

            : Icons.dark_mode,
      ),
    ),

  ],
), 

      body: SingleChildScrollView(

        padding: EdgeInsets.all(
          Responsive.padding(context),
        ),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(

              "Mi Progreso",

              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(179, 64, 129, 3),
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
              style: TextStyle(
                color: AppColors.textSecondary(context),
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

      if (Responsive.isMobile(context)) {
      return 2;
    }

    if (Responsive.isTablet(context)) {
      return 2;
    }

  return 4;
  }
}