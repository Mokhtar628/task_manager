import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/features/task_manager/domain/entities/task.dart';
import 'package:task_manager/features/task_manager/domain/repositories_interface/task_repository.dart';
import 'package:task_manager/features/task_manager/domain/usecases/get_tasks.dart';
import '../mocks/mocks.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  group('GetTasksUseCase Tests', () {
    late MockTaskRepository mockRepository;
    late GetTasksUseCase getTasksUseCase;

    setUp(() {
      mockRepository = MockTaskRepository();
      getTasksUseCase = GetTasksUseCase(mockRepository);
    });

    test('should call getTasks method on repository', () async {
      final tasks = [
        Task(id: 1, todo: 'Task 1', completed: false),
        Task(id: 2, todo: 'Task 2', completed: true),
      ];

      when(mockRepository.getTasks(3, 10)).thenAnswer((_) async => tasks);

      final result = await getTasksUseCase.call(3, 10);

      verify(mockRepository.getTasks(3, 10)).called(1);
      expect(result, tasks);
    });

    test('should throw an exception if repository fails', () async {
      when(mockRepository.getTasks(3, 10))
          .thenThrow(Exception('Fetching tasks failed'));

      expect(() => getTasksUseCase.call(3, 10), throwsException);
    });
  });
}