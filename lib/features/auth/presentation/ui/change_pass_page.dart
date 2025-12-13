import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_bloc.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_event.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_state.dart';
import 'package:orbiq/features/auth/presentation/utils/auth_error_helper.dart';

class ChangePasswordPage extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final String username;

  ChangePasswordPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.changePassword)),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is PasswordUpdateSuccess) {
            Navigator.pushReplacementNamed(context, '/login');
          } else if (state is AuthFailure) {
            final errorMessage = getLocalizedErrorMessage(
              l10n,
              state.failureType,
              extraMessage: state.extraMessage,
            );
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(errorMessage)));
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
                  decoration: InputDecoration(labelText: l10n.newPassword),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final newPassword = _passwordController.text;
                    if (newPassword.isNotEmpty) {
                      context.read<AuthBloc>().add(
                        UpdatePasswordRequested(
                          username: username,
                          newPassword: newPassword,
                        ),
                      );
                    }
                  },
                  child: Text(l10n.updatePasswordButton),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
