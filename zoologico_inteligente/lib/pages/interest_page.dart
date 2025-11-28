import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InterestPage extends StatefulWidget {
  const InterestPage({super.key});

  @override
  State<InterestPage> createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  String accountType = 'Ahorros';
  String amountText = '';
  String resultText = '';

  void calculateInterest() {
    
    
    List<String> _images = [];

    
    if (accountType == 'Ahorros') {
      _images = [
        'Tigre',
        'Mono',
        'Hipopotamo',
      ];
    } else if (accountType == 'Corriente') {
      _images = [
        'Elefante',
        'Girafa',
        'Sebra',
      ];
    } else if (accountType == 'Plazo fijo') {
      _images = [
        'Delfin',
        'Tiburon',
        'Ballena',
      ];
    } else if (accountType == 'Aviario') {
      _images = [
        'Colibríes',
        'Loros',
        'Gaviotas',
      ];
    }

    
    setState(() {
      resultText = _images.join(', ');
        print('Animales del Habitad');
      for (var i = 0; i < _images.length; i++) {
        print(_images[i]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animales por hábitat'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/zoo.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Elegir hábitat',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            DropdownButton<String>(
              value: accountType,
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: 'Ahorros',
                  child: Text('Selva'),
                ),
                DropdownMenuItem(
                  value: 'Corriente',
                  child: Text('Sabana'),
                ),
                DropdownMenuItem(
                  value: 'Plazo fijo',
                  child: Text('Acuático'),
                ),
                DropdownMenuItem(
                  value: 'Aviario',
                  child: Text('Aviario'),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  accountType = value;
                });
              },
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateInterest,
              child: const Text('Presentar Animales'),
            ),

            const SizedBox(height: 16),
            Text(
              resultText,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
