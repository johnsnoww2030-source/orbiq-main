import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/database/app_database.dart';
import 'package:orbiq/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'package:orbiq/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:orbiq/features/auth/domain/usecases/add_user_usecase.dart';
import 'package:orbiq/features/auth/domain/usecases/login_usecase.dart';
import 'package:orbiq/features/auth/domain/usecases/logout_usecase.dart';
import 'package:orbiq/features/auth/domain/usecases/update_password_usecase.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_bloc.dart';

List<BlocProvider> authBlocProviders(AppDatabase database) {
  // ایجاد UserDao
  final userDao = database.userDao;

  // ایجاد DataSource و Repository برای مدیریت اطلاعات کاربران
  final authLocalDataSource = AuthLocalDataSource(userDao);
  final authRepository = AuthRepositoryImpl(authLocalDataSource);

  // ایجاد UseCase ها برای auth
  final loginUseCase = LoginUseCase(authRepository);
  final updatePasswordUseCase = UpdatePasswordUseCase(authRepository);
  final logoutUseCase = LogoutUseCase(authRepository);
  final addUserUseCase = AddUserUseCase(authRepository);

  return [
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(
        loginUseCase: loginUseCase,
        updatePasswordUseCase: updatePasswordUseCase,
        logoutUseCase: logoutUseCase,
        addUserUseCase: addUserUseCase,
      ),
    ),
  ];
}
