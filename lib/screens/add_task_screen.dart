import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_done_list/models/task.dart';
import 'package:to_done_list/providers/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  String _category = 'งาน';
  int _difficulty = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('เพิ่มภารกิจ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'ชื่อภารกิจ'),
                validator: (value) => value!.isEmpty ? 'กรุณากรอกข้อมูล' : null,
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
                decoration: const InputDecoration(labelText: 'หมวดหมู่'),
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
                  if (_formKey.currentState!.validate()) {
                    final newTask = Task(
                      title: _titleController.text,
                      date: DateTime.now(),
                      category: _category,
                      difficulty: _difficulty,
                    );
                    Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
                    Navigator.pop(context);
                  }
                },
                child: const Text('บันทึก'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}