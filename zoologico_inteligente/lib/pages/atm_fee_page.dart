import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AtmFeePage extends StatefulWidget {
  const AtmFeePage({super.key});

  @override
  State<AtmFeePage> createState() => _AtmFeePageState();
}

class _AtmFeePageState extends State<AtmFeePage> {
  final TextEditingController animalController = TextEditingController();
  final List<String> favorites = [];

  void addFavorite() {
    final animal = animalController.text.trim();

    if (animal.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingrese el nombre de un animal')),
      );
      return;
    }

    setState(() {
      favorites.add(animal);
      animalController.clear();
    });
  }

  void removeFavorite(int index) {
    setState(() {
      favorites.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos del zoológico'),
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
            const Text(
              'Agrega tus animales favoritos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: animalController,
              decoration: const InputDecoration(
                labelText: 'Nombre del animal',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: addFavorite,
              child: const Text('Agregar a favoritos'),
            ),

            const SizedBox(height: 20),

            Text(
              "Total de animales favoritos: ${favorites.length}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(favorites[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => removeFavorite(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
