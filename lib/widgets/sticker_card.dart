import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

class StickerCard extends StatelessWidget {

  final int number;
  final bool obtained;
  final VoidCallback onTap;

  const StickerCard({
    super.key,
    required this.number,
    required this.obtained,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Material(

      color: Colors.transparent,

      child: InkWell(

        borderRadius: BorderRadius.circular(16),

        onTap: onTap,

        child: AnimatedContainer(

          duration: const Duration(milliseconds: 180),

          decoration: BoxDecoration(

            color: obtained
                ? Colors.green
                : AppColors.stickerInactive(context),

            borderRadius:
                BorderRadius.circular(16),

            border: Border.all(

              color: obtained
                  ? Colors.greenAccent
                  : Colors.black12,
            ),
          ),

          child: Stack(

            children: [

              Positioned(

                top: 6,
                right: 6,

                child: Icon(

                  obtained
                      ? Icons.check_circle
                      : Icons.circle_outlined,

                  size: 16,

                  color: obtained
                      ? Colors.white
                      : Colors.grey,
                ),
              ),

              Center(

                child: Text(

                  number
                      .toString()
                      .padLeft(3, '0'),

                  style: TextStyle(

                    color: obtained
                        ? Colors.white
                        : AppColors.textPrimary(
                            context),

                    fontWeight:
                        FontWeight.bold,

                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}