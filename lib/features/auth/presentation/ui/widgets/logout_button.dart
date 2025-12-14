import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/di/injection.dart';
import 'package:orbiq/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_bloc.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_state.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_event.dart';

/// دکمه خروج از سیستم
/// uuid کاربر از DataSource گرفته می‌شود (نه id)
class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  String? _userUuid;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadLoggedInUser();
  }

  Future<void> _loadLoggedInUser() async {
    final dataSource = getIt<AuthLocalDataSource>();
    final user = await dataSource.getLoggedInUser();
    if (mounted) {
      setState(() {
        _userUuid = user?.uuid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnauthenticatedState) {
          // هدایت به صفحه لاگین پس از تغییر وضعیت به UnauthenticatedState
          Navigator.pushReplacementNamed(context, '/login');
        } else if (state is AuthLoading) {
          if (mounted) {
            setState(() {
              _isLoading = true;
            });
          }
        } else if (state is AuthSuccess) {
          // اگر لاگین موفق بود، uuid را آپدیت کن
          if (mounted) {
            setState(() {
              _userUuid = state.user.uuid;
              _isLoading = false;
            });
          }
        } else {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        }
      },
      child: _isLoading
          ? const SizedBox(
              width: 48,
              height: 48,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          : IconButton(
              icon: const Icon(Icons.logout),
              onPressed: _userUuid != null
                  ? () {
                      setState(() {
                        _isLoading = true;
                      });
                      // ارسال رویداد Logout به BLoC با uuid کاربر
                      context.read<AuthBloc>().add(
                        LogoutRequested(userUuid: _userUuid!),
                      );
                    }
                  : null,
            ),
    );
  }
}
