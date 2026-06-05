import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/sticker_model.dart';

final stickerProvider =
    StateNotifierProvider<StickerNotifier, List<StickerModel>>((ref) {
      return StickerNotifier();
    });

class StickerNotifier extends StateNotifier<List<StickerModel>> {
  StickerNotifier() : super([]) {
    loadStickers();
  }

  static const storageKey = 'stickers_progress';

  final Set<String> unlockedRewards = {};

  Future<void> loadStickers() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(storageKey);

    if (data != null) {
      final decoded = jsonDecode(data) as List;

      state = decoded.map((item) {
        return StickerModel(number: item['number'], obtained: item['obtained']);
      }).toList();
    } else {
      state = List.generate(387, (index) => StickerModel(number: index + 1));
    }
  }

  Future<void> toggleSticker(int number) async {
    state = [
      for (final sticker in state)
        if (sticker.number == number)
          StickerModel(number: sticker.number, obtained: !sticker.obtained)
        else
          sticker,
    ];

    await saveStickers();
  }

  String? checkRewardUnlock(int number) {
    final rewardRanges = [
      ['Medias de fútbol', 1, 27],
      ['Camiseta', 28, 54],
      ['Balón', 55, 90],
      ['Celular', 91, 117],
      ['Premio sorpresa', 118, 153],
      ['Reloj', 154, 180],
      ['Billetera', 181, 216],
      ['Ajedrez', 217, 252],
      ['Dominó', 253, 279],
      ['Muñeco', 280, 315],
      ['Bicicleta', 316, 342],
      ['Parlante', 343, 387],
    ];

    for (final reward in rewardRanges) {
      final name = reward[0] as String;

      final start = reward[1] as int;

      final end = reward[2] as int;

      final completed = state
          .where((sticker) => sticker.number >= start && sticker.number <= end)
          .every((sticker) => sticker.obtained);

      if (completed && !unlockedRewards.contains(name)) {
        unlockedRewards.add(name);

        return name;
      }
    }

    final completedAlbum = state.every((s) => s.obtained);

    if (completedAlbum && !unlockedRewards.contains('album')) {
      unlockedRewards.add('album');

      return 'ÁLBUM COMPLETO';
    }

    return null;
  }

  Future<void> saveStickers() async {
    final prefs = await SharedPreferences.getInstance();

    final encoded = jsonEncode(
      state.map((sticker) {
        return {'number': sticker.number, 'obtained': sticker.obtained};
      }).toList(),
    );

    await prefs.setString(storageKey, encoded);
  }

  Future<void> resetAlbum() async {
    state = List.generate(387, (index) => StickerModel(number: index + 1));

    unlockedRewards.clear();
    await saveStickers();
  }
}
