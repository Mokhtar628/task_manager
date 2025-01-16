import 'package:get_it/get_it.dart';
import '../data/data_source/local_task_datasource.dart';
import '../data/data_source/remote_task_datasource.dart';
import '../data/repositories/task_repository_imp.dart';
import '../domain/repositories_interface/task_repository.dart';
import '../domain/usecases/add_tasks.dart';
import '../domain/usecases/delete_tasks.dart';
import '../domain/usecases/get_tasks.dart';
import '../domain/usecases/update_tasks.dart';
import '../presentation/provider/task_provider.dart';

final GetIt injector = GetIt.instance;

void setup() {
  // Datasources
  injector.registerLazySingleton<RemoteTaskDatasource>(() => RemoteTaskDatasource());
  injector.registerLazySingleton<LocalTaskDatasource>(() => LocalTaskDatasource());

  // Repository
  injector.registerLazySingleton<TaskRepository>(
        () => TaskRepositoryImpl(
      localDatasource: injector<LocalTaskDatasource>(),
      remoteDatasource: injector<RemoteTaskDatasource>(),
    ),
  );

  // Use Cases
  injector.registerFactory<GetTasksUseCase>(() => GetTasksUseCase(injector<TaskRepository>()));
  injector.registerFactory<AddTaskUseCase>(() => AddTaskUseCase(injector<TaskRepository>()));
  injector.registerFactory<DeleteTaskUseCase>(() => DeleteTaskUseCase(injector<TaskRepository>()));
  injector.registerFactory<UpdateTaskUseCase>(() => UpdateTaskUseCase(injector<TaskRepository>()));

  // Provider
  injector.registerFactory<TaskProvider>(
        () => TaskProvider(
      getTasks: injector<GetTasksUseCase>(),
      addTaskUseCase: injector<AddTaskUseCase>(),
      deleteTaskUseCase: injector<DeleteTaskUseCase>(),
      updateTaskUseCase: injector<UpdateTaskUseCase>(),
    ),
  );
}

