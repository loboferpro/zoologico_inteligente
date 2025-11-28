import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BankHomePage extends StatelessWidget {
  const BankHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menú Zoológico Inteligente')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Bienvenidos al zoológicoSeleccione una opción:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Seleccione una opción:',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () => context.go('/interest'),
              child: const Text('Animales por hábitat'),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () => context.go('/loan'),
              child: const Text('Calculadora de alimento'),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () => context.go('/atm'),
              child: const Text('Favoritos del zoológico'),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () => context.go('/animales'),
              child: const Text('Plan dinámico de alimentación semanal'),
            ),
          ],
        ),
      ),
    );
  }
}
