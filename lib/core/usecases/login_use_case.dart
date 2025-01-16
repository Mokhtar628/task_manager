import '../../features/auth/domain/entities/user.dart';
import '../../features/auth/domain/repositories interface/auth_repo.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User> execute(String username, String password) async {
    return await repository.login(username, password);
  }
}
