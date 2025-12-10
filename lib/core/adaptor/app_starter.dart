import 'package:flutter/material.dart';
import 'package:orbiq/core/di/injection.dart';
import 'package:orbiq/core/shared/database/database.dart';
import 'package:orbiq/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'my_app.dart';

class AppStarter extends StatelessWidget {
  const AppStarter({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return _buildErrorScreen(snapshot.error);
          }
          return MyApp(database: getIt<AppDatabase>());
        }
        return _buildLoadingScreen();
      },
    );
  }

  /// متد برای مقداردهی اولیه دیتابیس و Seed کردن کاربر مدیر
  Future<void> _initializeApp() async {
    // 1. Initialize DI
    await configureDependencies();

    // 2. Get database from DI
    final database = getIt<AppDatabase>();

    // 3. کاربر مدیر را Seed کنید
    final userDao = database.userDao;
    final authLocalDataSource = AuthLocalDataSource(userDao);
    await authLocalDataSource.seedAdminUser();
  }

  Widget _buildErrorScreen(Object? error) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: Text('خطا در اتصال به دیتابیس: $error')),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
