import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Álbum Mundial ⚽"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Bienvenido",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [

                    const Text(
                      "Progreso General",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    LinearProgressIndicator(
                      value: 0.25,
                      minHeight: 15,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "25% completado",
                      style: TextStyle(fontSize: 16),
                    ),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}