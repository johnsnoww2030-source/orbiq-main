import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/services/navigation_service.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';

import 'package:orbiq/features/auth/presentation/controller/auth_bloc.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_event.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _usernameFocusNode = FocusNode();
  final NavigationService _navigationService = NavigationService();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocusNode.dispose();
    super.dispose();
  }

  void _performLogin(BuildContext context) {
    final username = _usernameController.text;
    final password = _passwordController.text;
    context.read<AuthBloc>().add(LoginRequested(username, password));
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            if (state.isManager) {
              _navigationService.navigateToManager(context);
            } else {
              _navigationService.navigateToSeller(context);
            }
          } else if (state is AuthFirstLogin) {
            _navigationService.navigateToChangePassword(
              context,
              state.username,
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // Image.asset(
              //   'lib/core/assets/images/login_background.jpg',
              //   fit: BoxFit.cover,
              //   width: double.infinity,
              //   height: double.infinity,
              // ),
              // Container(
              //   color: Colors.black.withValues(alpha: 0.5),
              // ),
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Icon(Icons.lock_outline, size: 80),
                        const SizedBox(height: 48),
                        _buildTextField(
                          controller: _usernameController,
                          focusNode: _usernameFocusNode,
                          icon: Icons.person_outline,
                          hintText: l10n.enterUsername,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) {
                            FocusScope.of(context).nextFocus();
                          },
                          autofocus: true,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _passwordController,
                          icon: Icons.lock_outline,
                          hintText: l10n.enterPassword,
                          isPassword: true,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) {
                            _performLogin(context);
                          },
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: state is AuthLoading
                              ? null
                              : () {
                                  _performLogin(context);
                                },
                          style: ElevatedButton.styleFrom(
                            // foregroundColor: Colors.white,
                            // backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: state is AuthLoading
                              ? const CircularProgressIndicator()
                              // color: Colors.white)
                              : Text(l10n.login),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    FocusNode? focusNode,
    required IconData icon,
    required String hintText,
    bool isPassword = false,
    TextInputAction? textInputAction,
    Function(String)? onSubmitted,
    bool autofocus = false,
  }) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      obscureText: isPassword,
      // style: const TextStyle(color: Color.fromARGB(221, 232, 226, 226)),
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      autofocus: autofocus,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
      ),
    );
  }
}
