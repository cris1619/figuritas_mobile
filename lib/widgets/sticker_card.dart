import 'package:flutter/material.dart';

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

    return InkWell(

      borderRadius: BorderRadius.circular(18),

      onTap: onTap,

      child: AnimatedContainer(

        duration: const Duration(milliseconds: 250),

        decoration: BoxDecoration(

          color: obtained
              ? const Color(0xFF22C55E)
              : const Color(0xFF1E293B),

          borderRadius: BorderRadius.circular(18),

          border: Border.all(
            color: obtained
                ? Colors.greenAccent
                : Colors.white12,
            width: 1.5,
          ),

          boxShadow: [

            if (obtained)
              BoxShadow(
                color: Colors.green.withOpacity(0.35),
                blurRadius: 12,
                spreadRadius: 1,
              ),

          ],
        ),

        child: Stack(

          children: [

            Positioned(
              top: 8,
              right: 8,
              child: Icon(
                obtained
                    ? Icons.check_circle
                    : Icons.circle_outlined,

                color: obtained
                    ? Colors.white
                    : Colors.white24,

                size: 18,
              ),
            ),

            Center(
              child: Text(

                number.toString().padLeft(3, '0'),

                style: TextStyle(

                  color: obtained
                      ? Colors.white
                      : Colors.white70,

                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}