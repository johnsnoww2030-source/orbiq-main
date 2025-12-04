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
import 'package:orbiq/features/auth/presentation/ui/widgets/navigation_drawer_widget.dart';
import 'package:orbiq/features/auth/presentation/ui/widgets/dashboard_content_widget.dart';

class ManagerPage extends StatefulWidget {
  const ManagerPage({super.key});

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  int _selectedIndex = 0;

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
          body: Row(
            children: [
              // Sidebar for Desktop/Tablet
              if (MediaQuery.of(context).size.width > 800)
                NavigationDrawerWidget(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onDestinationSelected,
                ),

              // Main Content
              Expanded(
                child: Column(
                  children: [
                    // Top Bar
                    _buildTopBar(context, l10n),

                    // Content Area
                    Expanded(child: _buildContent(_selectedIndex)),
                  ],
                ),
              ),
            ],
          ),
          // Drawer for Mobile
          drawer: MediaQuery.of(context).size.width <= 800
              ? NavigationDrawerWidget(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) {
                    Navigator.pop(context); // Close drawer
                    _onDestinationSelected(index);
                  },
                )
              : null,
        );
      },
    );
  }

  Widget _buildTopBar(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (MediaQuery.of(context).size.width <= 800)
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),

          // Search Bar (Visual only for now)
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(l10n.search, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Actions
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              final isDarkMode =
                  themeState is ThemeLoaded &&
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
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              Navigator.pushNamed(context, '/settings/language');
            },
            tooltip: l10n.language,
          ),
          const SizedBox(width: 8),
          const LogoutButton(),
        ],
      ),
    );
  }

  Widget _buildContent(int index) {
    // Map index to content
    switch (index) {
      case 0:
        return const DashboardContentWidget();
      case 1: // Transactions
        return _buildPlaceholder("Transactions Content");
      case 2: // Invoices
        return _buildPlaceholder("Invoices Content");
      case 3: // Barcode Reader
        return _buildPlaceholder("Barcode Reader Content");
      case 4: // Reports
        return _buildPlaceholder("Reports Content");
      case 5: // Customers
        return _buildPlaceholder("Customers Content");
      case 6: // Vendors
        return _buildPlaceholder("Vendors Content");
      case 7: // Products
        return _buildPlaceholder("Products Content");
      case 8: // Reminders
        return _buildPlaceholder("Reminders Content");
      case 9: // Support
        return _buildPlaceholder("Support Content");
      case 10: // Settings
        return _buildPlaceholder("Settings Content");
      default:
        return const DashboardContentWidget();
    }
  }

  Widget _buildPlaceholder(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.construction, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(title, style: TextStyle(fontSize: 24, color: Colors.grey[600])),
          const SizedBox(height: 8),
          const Text("Coming Soon"),
        ],
      ),
    );
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle specific navigation if needed
    // For example, if some items should open new routes instead of changing content
    if (index == 3) {
      // Barcode Reader
      // Navigator.pushNamed(context, '/barcode');
      // Uncomment if you want to push to a separate page
    }
  }
}
