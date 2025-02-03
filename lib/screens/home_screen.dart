import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_done_list/providers/task_provider.dart';
import 'package:to_done_list/screens/add_task_screen.dart';
import 'edit_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateToEditScreen(BuildContext context, int index) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final task = taskProvider.tasks[index];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditTaskScreen(
          index: index,
          task: task,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Done List 🏆'),
        actions: [
          IconButton(
            icon: const Icon(Icons.leaderboard),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddTaskScreen()),
        ),
      ),
      body: ListView.builder(
        itemCount: taskProvider.tasks.length,
        itemBuilder: (context, index) => Dismissible(
          key: Key(taskProvider.tasks[index].title),
          background: Container(color: Colors.red),
          onDismissed: (direction) => taskProvider.deleteTask(index),
          child: Card(
            child: ListTile(
              title: Text(taskProvider.tasks[index].title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'วันที่: ${DateFormat('dd/mm/yyy').format(taskProvider.tasks[index].date)}'),
                  Text('ความยาก: ${'⭐'* taskProvider.tasks[index].difficulty}'),
                ],
              ),
              trailing: IconButton(
                onPressed: () => _navigateToEditScreen(context, index), 
                icon: const Icon(Icons.edit)),
            ),
          ),
        ),
      ),
    );
  }
}
