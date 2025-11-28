import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';

import 'package:orbiq/core/shared/theme/domain/entities/theme_entity.dart';
import 'package:orbiq/features/auth/presentation/ui/widgets/logout_button.dart';
import 'package:orbiq/core/shared/theme/presentation/controller/theme_bloc.dart';
import 'package:orbiq/core/shared/theme/presentation/controller/theme_event.dart';
import 'package:orbiq/core/shared/theme/presentation/controller/theme_state.dart';

class SellerPage extends StatelessWidget {
  const SellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.sellerDashboard,
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
                l10n.welcomeSeller,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  crossAxisCount: MediaQuery.of(context).size.width > 1000
                      ? 4
                      : MediaQuery.of(context).size.width > 600
                          ? 3
                          : 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildDashboardCard(
                      context,
                      l10n.sale,
                      Icons.shopping_cart,
                      Colors.orange,
                      () => Navigator.pushNamed(context, '/products'),
                    ),
                    _buildDashboardCard(
                      context,
                      l10n.addProduct,
                      Icons.add_box,
                      Colors.blue,
                      () => Navigator.pushNamed(context, '/add-product'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
