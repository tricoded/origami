import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  List<Map<String, dynamic>> exerciseLog = [];

  final List<Map<String, dynamic>> exerciseTypes = [
    {'icon': Icons.directions_run, 'label': 'Run'},
    {'icon': Icons.self_improvement, 'label': 'Yoga'},
    {'icon': Icons.directions_bike, 'label': 'Cycle'},
    {'icon': Icons.fitness_center, 'label': 'Lift'},
    {'icon': Icons.sports_mma, 'label': 'Box'},
    {'icon': Icons.sports_soccer, 'label': 'Sports'},
    {'icon': Icons.add, 'label': 'Custom'},
  ];

  void _addExercise(String type, int duration, String notes, File? imageFile) {
    setState(() {
      exerciseLog.add({
        'type': type,
        'duration': duration,
        'notes': notes,
        'image': imageFile,
        'time': DateTime.now(),
      });
    });
  }

  void _editExercise(int index, int newDuration, String newNotes) {
    setState(() {
      exerciseLog[index]['duration'] = newDuration;
      exerciseLog[index]['notes'] = newNotes;
    });
  }

  void _showAddExerciseDialog(String type) {
    int duration = 0;
    String notes = '';
    File? imageFile;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Add $type Entry', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Duration (minutes)'),
              onChanged: (val) => duration = int.tryParse(val) ?? 0,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Notes (optional)'),
              onChanged: (val) => notes = val,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final picker = ImagePicker();
                    final picked = await picker.pickImage(source: ImageSource.gallery);
                    if (picked != null) {
                      setState(() => imageFile = File(picked.path));
                    }
                  },
                  icon: const Icon(Icons.photo),
                  label: const Text('Add Photo'),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    if (duration > 0) {
                      _addExercise(type, duration, notes, imageFile);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add Entry'),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(int index) {
    final current = exerciseLog[index];
    int newDuration = current['duration'];
    String newNotes = current['notes'];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Entry'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Duration (minutes)'),
              controller: TextEditingController(text: newDuration.toString()),
              onChanged: (val) => newDuration = int.tryParse(val) ?? current['duration'],
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Notes'),
              controller: TextEditingController(text: newNotes),
              onChanged: (val) => newNotes = val,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              _editExercise(index, newDuration, newNotes);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final todayEntries = exerciseLog.where((e) =>
      e['time'].day == today.day &&
      e['time'].month == today.month &&
      e['time'].year == today.year).toList();

    final totalDuration = todayEntries.fold<int>(0, (sum, e) => sum + ((e['duration'] as int? ?? 0)));

    return Scaffold(
      appBar: AppBar(
        title: const Text('EXERCISE'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Today - ${today.month}/${today.day}/${today.year}", style: const TextStyle(fontSize: 16)),
            Text("Total Duration: $totalDuration min", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              itemCount: exerciseTypes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final type = exerciseTypes[index];
                return GestureDetector(
                  onTap: () => _showAddExerciseDialog(type['label']),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        child: Icon(type['icon'], size: 24),
                      ),
                      const SizedBox(height: 4),
                      Text(type['label'], style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text("Today's Log:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: todayEntries.isEmpty
                  ? const Center(child: Text('No entries yet'))
                  : ListView.builder(
                      itemCount: todayEntries.length,
                      itemBuilder: (context, index) {
                        final entry = todayEntries[index];
                        return Dismissible(
                          key: UniqueKey(),
                          background: Container(
                            color: Colors.blue,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 20),
                            child: const Icon(Icons.edit, color: Colors.white),
                          ),
                          secondaryBackground: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child: const Icon(Icons.delete, color: Colors.white),
                          ),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              _showEditDialog(index);
                              return false;
                            } else {
                              setState(() => exerciseLog.removeAt(index));
                              return true;
                            }
                          },
                          child: Card(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              leading: const Icon(Icons.fitness_center),
                              title: Text("${entry['type']} - ${entry['duration']} min"),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (entry['notes'] != '') Text(entry['notes']),
                                  Text("${entry['time'].hour.toString().padLeft(2, '0')}:${entry['time'].minute.toString().padLeft(2, '0')}"),
                                ],
                              ),
                              trailing: entry['image'] != null
                                  ? Image.file(entry['image'], width: 40, height: 40, fit: BoxFit.cover)
                                  : null,
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
