import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks(int limit, int skip);
  Future<void> addTask(Task task);
  Future<void> deleteTask(int taskId);
  Future<void> updateTask(Task task);
}
