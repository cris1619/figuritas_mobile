import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/sticker_provider.dart';
import '../../utils/filter_type.dart';
import '../../widgets/sticker_card.dart';
import '../../core/responsive/responsive.dart';
import '../../core/theme/app_colors.dart';

class StickersScreen extends ConsumerStatefulWidget {
  const StickersScreen({super.key});

  @override
  ConsumerState<StickersScreen> createState() => _StickersScreenState();
}

class _StickersScreenState extends ConsumerState<StickersScreen> {
  String search = '';

  FilterType filter = FilterType.all;

  int currentPage = 1;

  final int itemsPerPage = 40;

  @override
  Widget build(BuildContext context) {
    final stickers = ref.watch(stickerProvider);

    if (stickers.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    var filtered = stickers.where((sticker) {
      final matchesSearch = sticker.number.toString().contains(search);

      final matchesFilter = switch (filter) {
        FilterType.all => true,

        FilterType.obtained => sticker.obtained,

        FilterType.missing => !sticker.obtained,
      };

      return matchesSearch && matchesFilter;
    }).toList();

    final totalPages = (filtered.length / itemsPerPage).ceil();

    final start = (currentPage - 1) * itemsPerPage;

    final end = (start + itemsPerPage).clamp(0, filtered.length);

    final paginated = filtered.sublist(start, end);

    final obtained = stickers.where((s) => s.obtained).length;

    final progress = obtained / 387;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Figuritas ⚽"),

        actions: [
          IconButton(
            onPressed: () {
              _showResetDialog(context);
            },

            icon: const Icon(Icons.restart_alt),
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(Responsive.padding(context)),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "$obtained / 387 Figuritas",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary(context),
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

                const SizedBox(height: 20),

                TextField(
                  onChanged: (value) {
                    setState(() {
                      search = value;

                      currentPage = 1;
                    });
                  },

                  keyboardType: TextInputType.number,

                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: AppColors.textMuted(context)),

                    hintText: 'Buscar figurita...',

                    prefixIcon: const Icon(Icons.search),

                    filled: true,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),

                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                  child: Row(
                    children: [
                      _buildFilterChip(label: 'Todas', value: FilterType.all),

                      _buildFilterChip(
                        label: 'Obtenidas',
                        value: FilterType.obtained,
                      ),

                      _buildFilterChip(
                        label: 'Faltantes',
                        value: FilterType.missing,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              child: GridView.builder(
                cacheExtent: 500,

                itemCount: paginated.length,

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.gridCount(context),

                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,

                  childAspectRatio: 1,
                ),

                itemBuilder: (context, index) {
                  final sticker = paginated[index];

                  return StickerCard(
                    number: sticker.number,

                    obtained: sticker.obtained,

                    onTap: () async {
                      final notifier = ref.read(stickerProvider.notifier);

                      final messenger = ScaffoldMessenger.of(context);

                      await notifier.toggleSticker(sticker.number);

                      final reward = notifier.checkRewardUnlock(sticker.number);

                      if (!mounted) return;

                      if (reward != null) {
                        messenger.showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,

                            backgroundColor: Colors.green,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),

                            content: Row(
                              children: [
                                const Icon(
                                  Icons.emoji_events,
                                  color: Colors.white,
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: Text(
                                    reward == 'ÁLBUM COMPLETO'
                                        ? '🔥 ¡Completaste TODO el álbum!'
                                        : '🏆 Premio desbloqueado: $reward',

                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                ElevatedButton(
                  onPressed: currentPage > 1
                      ? () {
                          setState(() {
                            currentPage--;
                          });
                        }
                      : null,

                  child: const Text("Anterior"),
                ),

                const SizedBox(width: 20),

                Text(
                  "$currentPage / $totalPages",

                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary(context),
                  ),
                ),

                const SizedBox(width: 20),

                ElevatedButton(
                  onPressed: currentPage < totalPages
                      ? () {
                          setState(() {
                            currentPage++;
                          });
                        }
                      : null,

                  child: const Text("Siguiente"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({required String label, required FilterType value}) {
    final selected = filter == value;

    return Padding(
      padding: const EdgeInsets.only(right: 10),

      child: ChoiceChip(
        label: Text(label),

        selected: selected,

        onSelected: (_) {
          setState(() {
            filter = value;

            currentPage = 1;
          });
        },
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,

      builder: (_) {
        return AlertDialog(
          title: const Text("Reiniciar álbum"),

          content: const Text("¿Seguro que deseas borrar el progreso?"),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text("Cancelar"),
            ),

            ElevatedButton(
              onPressed: () {
                ref.read(stickerProvider.notifier).resetAlbum();

                Navigator.pop(context);
              },

              child: const Text("Reiniciar"),
            ),
          ],
        );
      },
    );
  }
}
