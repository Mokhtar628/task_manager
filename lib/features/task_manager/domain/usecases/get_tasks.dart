import '../entities/task.dart';
import '../repositories_interface/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository repository;

  GetTasksUseCase(this.repository);

  Future<List<Task>> call(int limit, int skip, {String statusFilter = 'all'}) async {
    // Fetch all tasks without filter
    List<Task> allTasks = await repository.getTasks(limit, skip);

    // Apply filtering based on the statusFilter
    List<Task> filteredTasks = [];

    if (statusFilter == 'completed') {
      filteredTasks = allTasks.where((task) => task.completed).toList();
    } else if (statusFilter == 'incomplete') {
      filteredTasks = allTasks.where((task) => !task.completed).toList();
    } else {
      // If no filter or invalid filter, return all tasks
      filteredTasks = allTasks;
    }

    return filteredTasks;
  }
}
