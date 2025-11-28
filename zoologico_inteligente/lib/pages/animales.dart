import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TreatmentItem {
  final String patient;
  final String treatment;
  final double cost;

  TreatmentItem({
    required this.patient,
    required this.treatment,
    required this.cost,
  });
}

class AnimalsPage extends StatefulWidget {
  const AnimalsPage({super.key});

  @override
  State<AnimalsPage> createState() => _AnimalsPageState();
}

class _AnimalsPageState extends State<AnimalsPage> {
  final TextEditingController animalController = TextEditingController();
  final TextEditingController treatmentController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final List<TreatmentItem> treatments = [];
  String resultText = '';

  @override
  void dispose() {
    animalController.dispose();
    treatmentController.dispose();
    costController.dispose();
    super.dispose();
  }

  void addTreatment() {
    final patient = animalController.text.trim();
    final treatment = treatmentController.text.trim();
    final costText = costController.text.trim();

    if (patient.isEmpty || costText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa al menos animal y alimento gramos')),
      );
      return;
    }

    final cost = double.tryParse(costText.replaceAll(',', '.')) ?? 0;
    if (cost <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa gramos válidos')),
      );
      return;
    }

    setState(() {
      treatments.add(
        TreatmentItem(
          patient: patient,
          treatment: treatment.isEmpty ? 'Sin detalle' : treatment,
          cost: cost,
        ),
      );
      animalController.clear();
      treatmentController.clear();
      costController.clear();
      resultText = '';
    });
  }

  void removeTreatment(int index) {
    setState(() {
      treatments.removeAt(index);
      resultText = '';
    });
  }

  void calculateBilling() {
    if (treatments.isEmpty) {
      setState(() {
        resultText = 'No hay animales registrados.';
      });
      return;
    }
    double total = 0;
    for (int i = 0; i < treatments.length; i++) {
      total += treatments[i].cost;
    }
    final count = treatments.length;
    final average = total / count;
    setState(() {
      resultText =
        'Total alimeto: \$${total.toStringAsFixed(2)}\n'
        'Cantidad de animales: $count';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan dinámico de alimentación semanal'),
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
            TextField(
              controller: animalController,
              decoration: const InputDecoration(
                labelText: 'Nombre del animal',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: costController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Gramos de alimento',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: addTreatment,
              child: const Text('Agregar Animal'),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: treatments.isEmpty
                  ? const Center(child: Text('No hay animales registrados.'))
                  : ListView.builder(
                      itemCount: treatments.length,
                      itemBuilder: (context, index) {
                        final item = treatments[index];
                        return Card(
                          child: ListTile(
                            title: Text(item.patient),
                            subtitle: Text(
                              '${item.treatment} - \$${item.cost.toStringAsFixed(2)}',
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => removeTreatment(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: calculateBilling,
              child: const Text('Calcular resumen'),
            ),
            const SizedBox(height: 8),
            Text(resultText),
          ],
        ),
      ),
    );
  }
}