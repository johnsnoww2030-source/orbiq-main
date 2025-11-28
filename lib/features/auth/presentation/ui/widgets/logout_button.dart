import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_bloc.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_state.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_event.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnauthenticatedState) {
          // هدایت به صفحه لاگین پس از تغییر وضعیت به UnauthenticatedState
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          // بررسی وضعیت برای دریافت ID کاربر
          if (state is AuthSuccess) {
            final userId = state.user.id; // دسترسی به ID کاربر از طریق شیء user

            return IconButton(
              icon: const Icon(
                Icons.logout,
                // color: Colors.grey,
              ),
              onPressed: () {
                // ارسال رویداد Logout به BLoC با userId کاربر
                context.read<AuthBloc>().add(LogoutRequested(userId: userId!));
              },
            );
          }

          // اگر کاربر وارد نشده باشد، هیچ دکمه‌ای نمایش داده نشود
          return Container();
        },
      ),
    );
  }
}
