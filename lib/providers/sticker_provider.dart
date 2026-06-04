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

  Future<void> loadStickers() async {

    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(storageKey);

    if (data != null) {

      final decoded = jsonDecode(data) as List;

      state = decoded.map((item) {

        return StickerModel(
          number: item['number'],
          obtained: item['obtained'],
        );

      }).toList();

    } else {

      state = List.generate(
        387,
        (index) => StickerModel(number: index + 1),
      );

    }
  }

  Future<void> toggleSticker(int number) async {

    state = [

      for (final sticker in state)

        if (sticker.number == number)

          StickerModel(
            number: sticker.number,
            obtained: !sticker.obtained,
          )

        else
          sticker,
    ];

    await saveStickers();
  }

  Future<void> saveStickers() async {

    final prefs = await SharedPreferences.getInstance();

    final encoded = jsonEncode(

      state.map((sticker) {

        return {
          'number': sticker.number,
          'obtained': sticker.obtained,
        };

      }).toList(),

    );

    await prefs.setString(storageKey, encoded);
  }

  Future<void> resetAlbum() async {

    state = List.generate(
      387,
      (index) => StickerModel(number: index + 1),
    );

    await saveStickers();
  }

}