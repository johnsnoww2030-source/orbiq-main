import 'package:flutter/material.dart';
import 'package:orbiq/core/shared/database/database.dart';
import 'package:orbiq/core/adaptor/database_provider.dart';
import 'package:orbiq/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'my_app.dart';

class AppStarter extends StatelessWidget {
  const AppStarter({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppDatabase>(
      future:
          _initializeApp(), // اینجا ما به جای دیتابیس فقط متد initializeApp را صدا می‌زنیم
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return _buildErrorScreen(snapshot.error);
          }
          return MyApp(
            database: snapshot.data!,
          ); // بعد از seed کردن کاربر مدیر، اپلیکیشن بارگذاری می‌شود
        }
        return _buildLoadingScreen();
      },
    );
  }

  /// متد برای مقداردهی اولیه دیتابیس و Seed کردن کاربر مدیر
  Future<AppDatabase> _initializeApp() async {
    // 1. دیتابیس را آماده کنید
    final database = await DatabaseProvider().databaseInstance;

    // 2. کاربر مدیر را Seed کنید
    final userDao = database.userDao; // گرفتن UserDao از دیتابیس
    final authLocalDataSource =
        AuthLocalDataSource(userDao); // پاس دادن UserDao به AuthLocalDataSource
    await authLocalDataSource.seedAdminUser();

    // 3. دیتابیس را برگردانید
    return database;
  }

  Widget _buildErrorScreen(Object? error) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text('خطا در اتصال به دیتابیس: $error'),
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
