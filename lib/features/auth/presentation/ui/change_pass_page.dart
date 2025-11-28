// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_bloc.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_event.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_state.dart';

class ChangePasswordPage extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final String username;

  ChangePasswordPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is PasswordUpdateSuccess) {
            // هدایت به صفحه ورود بعد از تغییر موفقیت‌آمیز رمز عبور
            Navigator.pushReplacementNamed(context, '/login');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'New Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    try {
                      final newPassword = _passwordController.text;

                      // بررسی مقدار رمز عبور

                      context.read<AuthBloc>().add(
                            UpdatePasswordRequested(
                              username: username,
                              newPassword: newPassword,
                            ),
                          );
                    } catch (e) {
                      print('Exception caught: $e');
                    }
                  },
                  child: const Text('Update Password'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
