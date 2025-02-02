import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_done_list/providers/task_provider.dart';
import 'package:to_done_list/screens/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          child: ListTile(
            title: Text(taskProvider.tasks[index].title),
            subtitle: Text(
              '${taskProvider.tasks[index].category} • '
              '⭐' * taskProvider.tasks[index].difficulty,
            ),
          ),
        ),
      ),
    );
  }
}