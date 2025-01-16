import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/features/task_manager/domain/entities/task.dart';
import 'package:task_manager/features/task_manager/domain/repositories_interface/task_repository.dart';
import 'package:task_manager/features/task_manager/domain/usecases/update_tasks.dart';

import '../mocks/mocks.mocks.dart';


@GenerateMocks([TaskRepository])
void main() {
  group('UpdateTaskUseCase Tests', () {
    late MockTaskRepository mockRepository;
    late UpdateTaskUseCase updateTaskUseCase;

    setUp(() {
      mockRepository = MockTaskRepository();
      updateTaskUseCase = UpdateTaskUseCase(mockRepository);
    });

    test('should call updateTask method on repository', () async {
      final task = Task(id: 1, todo: 'Updated Task', completed: true);
      when(mockRepository.updateTask(task)).thenAnswer((_) async {});

      await updateTaskUseCase.call(task);

      verify(mockRepository.updateTask(task)).called(1);
    });

    test('should throw an exception if repository fails', () async {
      final task = Task(id: 1, todo: 'Updated Task', completed: true);
      when(mockRepository.updateTask(task)).thenThrow(Exception('Update failed'));

      expect(() => updateTaskUseCase.call(task), throwsException);
    });
  });
}
