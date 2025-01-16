import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:task_manager/features/task_manager/domain/entities/task.dart';
import 'package:task_manager/features/task_manager/domain/repositories_interface/task_repository.dart';
import 'package:task_manager/features/task_manager/domain/usecases/add_tasks.dart';
import '../mocks/mocks.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late AddTaskUseCase addTaskUseCase;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    addTaskUseCase = AddTaskUseCase(mockTaskRepository);
  });

  group('AddTaskUseCase Tests', () {
    test('should call addTask method on repository', () async {
      final task = Task(id: 1, todo: 'Test Task', completed: false);

      await addTaskUseCase(task);

      verify(mockTaskRepository.addTask(task)).called(1);
    });

    test('should throw an exception if repository fails', () async {
      final task = Task(id: 1, todo: 'Test Task', completed: false);

      when(mockTaskRepository.addTask(task)).thenThrow(Exception('Failed to add task'));

      expect(() => addTaskUseCase(task), throwsException);
      verify(mockTaskRepository.addTask(task)).called(1);
    });
  });
}
