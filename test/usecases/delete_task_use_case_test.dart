import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/features/task_manager/domain/entities/task.dart';
import 'package:task_manager/features/task_manager/domain/repositories_interface/task_repository.dart';
import 'package:task_manager/features/task_manager/domain/usecases/delete_tasks.dart';

import '../mocks/mocks.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  group('DeleteTaskUseCase Tests', () {
    late MockTaskRepository mockRepository;
    late DeleteTaskUseCase deleteTaskUseCase;

    setUp(() {
      mockRepository = MockTaskRepository();
      deleteTaskUseCase = DeleteTaskUseCase(mockRepository);
    });

    test('should call deleteTask method on repository', () async {
      final task = Task(id: 1, todo: 'Test Todo', completed: false);
      when(mockRepository.deleteTask(1)).thenAnswer((_) async {});

      await deleteTaskUseCase.call(task.id);

      verify(mockRepository.deleteTask(1)).called(1);
    });

    test('should throw an exception if repository fails', () async {
      when(mockRepository.deleteTask(1)).thenThrow(Exception('Deletion failed'));

      expect(() => deleteTaskUseCase.call(1), throwsException);
    });
  });
}

