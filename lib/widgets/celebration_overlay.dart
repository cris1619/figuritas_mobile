import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class CelebrationOverlay extends StatefulWidget {

  final Widget child;

  const CelebrationOverlay({
    super.key,
    required this.child,
  });

  @override
  State<CelebrationOverlay> createState() =>
      _CelebrationOverlayState();
}

class _CelebrationOverlayState
    extends State<CelebrationOverlay> {

  late ConfettiController controller;

  @override
  void initState() {

    super.initState();

    controller = ConfettiController(
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {

    controller.dispose();

    super.dispose();
  }

  void play() {
    controller.play();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(

      children: [

        widget.child,

        Align(

          alignment: Alignment.topCenter,

          child: ConfettiWidget(

            confettiController: controller,

            blastDirectionality:
                BlastDirectionality.explosive,

            shouldLoop: false,

            emissionFrequency: 0.05,

            numberOfParticles: 20,

            gravity: 0.2,
          ),
        ),
      ],
    );
  }
}