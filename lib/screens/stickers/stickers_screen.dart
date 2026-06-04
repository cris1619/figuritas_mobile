import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/sticker_provider.dart';
import '../../widgets/sticker_card.dart';

class StickersScreen extends ConsumerWidget {

  const StickersScreen({super.key});

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

    final obtained = stickers.where((s) => s.obtained).length;

    final progress = obtained / 387;

    return Scaffold(

      appBar: AppBar(

        title: const Text("Mis Figuritas ⚽"),

        actions: [

          IconButton(

            onPressed: () {

              _showResetDialog(context, ref);

            },

            icon: const Icon(Icons.restart_alt),
          ),

        ],
      ),

      body: Column(

        children: [

          Padding(
            padding: const EdgeInsets.all(16),

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(
                  "$obtained / 387 Figuritas",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                ClipRRect(

                  borderRadius: BorderRadius.circular(20),

                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 14,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "${(progress * 100).toStringAsFixed(1)}% completado",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),

              ],
            ),
          ),

          Expanded(

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              child: GridView.builder(

                itemCount: stickers.length,

                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(

                  crossAxisCount: _getCrossAxisCount(context),

                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,

                  childAspectRatio: 1,
                ),

                itemBuilder: (context, index) {

                  final sticker = stickers[index];

                  return StickerCard(

                    number: sticker.number,
                    obtained: sticker.obtained,

                    onTap: () {

                      ref
                          .read(stickerProvider.notifier)
                          .toggleSticker(sticker.number);

                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(
    BuildContext context,
    WidgetRef ref,
  ) {

    showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          title: const Text("Reiniciar álbum"),

          content: const Text(
            "¿Seguro que deseas borrar todo el progreso?"
          ),

          actions: [

            TextButton(

              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text("Cancelar"),
            ),

            ElevatedButton(

              onPressed: () {

                ref
                    .read(stickerProvider.notifier)
                    .resetAlbum();

                Navigator.pop(context);

              },

              child: const Text("Reiniciar"),
            ),

          ],
        );
      },
    );
  }

  int _getCrossAxisCount(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    if (width < 500) {
      return 4;
    } else if (width < 800) {
      return 6;
    } else if (width < 1200) {
      return 8;
    } else {
      return 10;
    }
  }
}