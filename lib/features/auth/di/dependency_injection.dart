import 'package:get_it/get_it.dart';
import '../../../core/network/api_client.dart';
import '../../../core/usecases/login_use_case.dart';
import '../data/data_source/auth_data_source.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories interface/auth_repo.dart';
import '../presentation/provider/auth_provider.dart';

final GetIt injector = GetIt.instance;

void setup() {
  injector.registerLazySingleton<ApiClient>(() => ApiClient());
  injector.registerLazySingleton<AuthDataSource>(() => AuthDataSource(apiClient: injector<ApiClient>()));
  injector.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(dataSource: injector<AuthDataSource>()));
  injector.registerFactory<LoginUseCase>(() => LoginUseCase(injector<AuthRepository>()));
  injector.registerFactory<AuthProvider>(() => AuthProvider(injector<LoginUseCase>(), injector<AuthRepository>()));
}
