import '../../domain/entities/task.dart';
import '../../domain/repositories_interface/task_repository.dart';
import '../data_source/local_task_datasource.dart';
import '../data_source/remote_task_datasource.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final RemoteTaskDatasource remoteDatasource;
  final LocalTaskDatasource localDatasource;

  TaskRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<List<Task>> getTasks(int limit, int skip) async {
    try {
      final tasks = await remoteDatasource.fetchTasks(limit: limit, skip: skip);
      await localDatasource.cacheTasks(tasks);
      return tasks.map((e) => Task(id: e.id, todo: e.todo, completed: e.completed)).toList();
    } catch (_) {
      final tasks = await localDatasource.getCachedTasks();
      return tasks.map((e) => Task(id: e.id, todo: e.todo, completed: e.completed)).toList();
    }
  }

  @override
  Future<void> addTask(Task task) async {
    final addedTask = await remoteDatasource.addTask(TaskModel(
      id: 0,
      todo: task.todo,
      completed: task.completed,
    ));
    await localDatasource.cacheTasks(await remoteDatasource.fetchTasks(limit: 10, skip: 0));
  }

  @override
  Future<void> deleteTask(int taskId) async {
    final deletedTask = await remoteDatasource.deleteTask(taskId);
    await localDatasource.cacheTasks(await remoteDatasource.fetchTasks(limit: 10, skip: 0));
  }

  @override
  Future<void> updateTask(Task task) async {
    final updatedTask = await remoteDatasource.updateTask(TaskModel(
      id: task.id,
      todo: task.todo,
      completed: task.completed,
    ));
    await localDatasource.cacheTasks(await remoteDatasource.fetchTasks(limit: 10, skip: 0));
  }
}
