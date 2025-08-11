import 'package:flutter/material.dart';

class StepsPage extends StatefulWidget {
  final String goalTitle;
  final String description;

  const StepsPage({super.key, required this.goalTitle, this.description = ''});

  @override
  State<StepsPage> createState() => _StepsPageState();
}

class _StepsPageState extends State<StepsPage> {
  List<Map<String, dynamic>> steps = [
    {'title': 'Define my vision', 'done': false},
    {'title': 'Learn basic business skills', 'done': true},
  ];

  void addStep(String title) {
    setState(() {
      steps.add({'title': title, 'done': false});
    });
  }

  void toggleStep(int index) {
    setState(() {
      steps[index]['done'] = !steps[index]['done'];
    });
  }

  void showAddStepDialog() {
    String newStep = '';
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add New Step'),
            content: TextField(
              onChanged: (val) => newStep = val,
              decoration: const InputDecoration(hintText: 'Enter your step'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (newStep.trim().isNotEmpty) addStep(newStep);
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.goalTitle)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.description.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      widget.description,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                const Text(
                  "Steps to Reach This Goal:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: steps.length,
              itemBuilder: (context, index) {
                final step = steps[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    leading: Checkbox(
                      value: step['done'],
                      onChanged: (_) => toggleStep(index),
                    ),
                    title: Text(step['title']),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_outward),
                      tooltip: 'Send to Short-Term Goals (coming soon)',
                      onPressed: null, // disable for now
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
  child: Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Center(
      child: TextButton.icon(
        onPressed: showAddStepDialog,
        icon: const Icon(Icons.add, size: 20),
        label: const Text(
          "Add a New Step",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    ),
  ),
),

        ],
      ),
    );
  }
}
