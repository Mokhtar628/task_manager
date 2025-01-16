import 'package:mockito/annotations.dart';
import 'package:task_manager/core/validators/form_validator.dart';
import 'package:task_manager/features/task_manager/domain/repositories_interface/task_repository.dart';

@GenerateMocks([TaskRepository, FormValidator])
void main() {}
