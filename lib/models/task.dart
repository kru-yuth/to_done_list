import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final int difficulty;

  @HiveField(4)
  final String? imagePath;

  Task({
    required this.title,
    required this.date,
    required this.category,
    required this.difficulty,
    this.imagePath,
  });
}