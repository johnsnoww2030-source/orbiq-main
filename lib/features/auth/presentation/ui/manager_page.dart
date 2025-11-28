import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';

import 'package:orbiq/core/shared/theme/domain/entities/theme_entity.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_bloc.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_state.dart';
import 'package:orbiq/features/auth/presentation/ui/widgets/logout_button.dart';
import 'package:orbiq/core/shared/theme/presentation/controller/theme_bloc.dart';
import 'package:orbiq/core/shared/theme/presentation/controller/theme_event.dart';
import 'package:orbiq/core/shared/theme/presentation/controller/theme_state.dart';

class ManagerPage extends StatefulWidget {
  const ManagerPage({super.key});

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is UnauthenticatedState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed('/login');
          });
          return Container();
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              l10n.managerDashboard,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  final isDarkMode = themeState is ThemeLoaded &&
                      themeState.theme.type == ThemeType.dark;

                  return IconButton(
                    icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
                    onPressed: () {
                      context.read<ThemeBloc>().add(ToggleThemeEvent());
                    },
                    tooltip: isDarkMode ? l10n.lightMode : l10n.darkMode,
                  );
                },
              ),
              const LogoutButton(),
              IconButton(
                icon: const Icon(Icons.language),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings/language');
                },
                tooltip: l10n.language,
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.welcomeManager,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).size.width > 1000
                            ? 5
                            : MediaQuery.of(context).size.width > 600
                                ? 3
                                : 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        final List<Map<String, dynamic>> items = [
                          {
                            'title': l10n.addProduct,
                            'icon': Icons.add_box,
                            'color': Colors.green,
                            'route': '/add-product'
                          },
                          {
                            'title': l10n.sale,
                            'icon': Icons.shopping_cart,
                            'color': Colors.orange,
                            'route': '/products'
                          },
                          {
                            'title': l10n.userManagement,
                            'icon': Icons.people,
                            'color': Colors.purple,
                            'route': '/userManagement'
                          },
                          {
                            'title': l10n.viewReports,
                            'icon': Icons.bar_chart,
                            'color': Colors.red,
                            'route': '/paymentsReport'
                          },
                          {
                            'title': l10n.update,
                            'icon': Icons.update,
                            'color': Colors.teal,
                            'route': '/update'
                          },
                        ];
                        final Map<String, dynamic> item = items[index];
                        return _buildDashboardCard(
                          context,
                          item['title'] as String,
                          item['icon'] as IconData,
                          item['color'] as Color,
                          () => _navigateTo(context, item['route'] as String),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDashboardCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
  }
}
