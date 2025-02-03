import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';

class EditTaskScreen extends StatefulWidget {
  final int index;
  final Task task;

  const EditTaskScreen({super.key, required this.index, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _titleController;
  late String _category;
  late int _difficulty;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _category = widget.task.category;
    _difficulty = widget.task.difficulty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('แก้ไขภารกิจ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'ชื่อภารกิจ'),
            ),
            DropdownButtonFormField<String>(
              value: _category,
              items: ['งาน', 'สุขภาพ', 'การเรียน'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) => setState(() => _category = value!),
            ),
            Slider(
              value: _difficulty.toDouble(),
              min: 1,
              max: 3,
              divisions: 2,
              label: 'ความยาก: $_difficulty',
              onChanged: (value) => setState(() => _difficulty = value.toInt()),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedTask = Task(
                  title: _titleController.text,
                  date: widget.task.date,
                  category: _category,
                  difficulty: _difficulty,
                );
                Provider.of<TaskProvider>(context, listen: false)
                    .editTask(widget.index, updatedTask);
                Navigator.pop(context);
              },
              child: const Text('บันทึกการเปลี่ยนแปลง'),
            ),
          ],
        ),
      ),
    );
  }
}