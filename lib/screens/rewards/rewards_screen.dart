import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/sticker_provider.dart';
import '../../utils/rewards_data.dart';
import '../../widgets/reward_card.dart';

class RewardsScreen extends ConsumerWidget {

  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final stickers = ref.watch(stickerProvider);

    return Scaffold(

      appBar: AppBar(
        title: const Text("Premios 🎁"),
      ),

      body: ListView.builder(

        padding: const EdgeInsets.all(16),

        itemCount: rewards.length,

        itemBuilder: (context, index) {

          final reward = rewards[index];

          final rewardStickers = stickers.where((sticker) {

            return sticker.number >= reward.start &&
                sticker.number <= reward.end;

          }).toList();

          final obtained = rewardStickers
              .where((sticker) => sticker.obtained)
              .length;

          final total =
              reward.end - reward.start + 1;

          return Padding(

            padding: const EdgeInsets.only(bottom: 16),

            child: RewardCard(

              title: reward.name,

              obtained: obtained,

              total: total,
            ),
          );
        },
      ),
    );
  }
}