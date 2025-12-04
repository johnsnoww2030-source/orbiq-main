import 'package:flutter/material.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const NavigationDrawerWidget({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      width: 100, // Reduced width for vertical layout
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          const SizedBox(height: 20),
          // App Logo
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.dashboard, color: Colors.white, size: 28),
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                _buildNavItem(
                  context,
                  index: 0,
                  icon: Icons.dashboard_outlined,
                  selectedIcon: Icons.dashboard,
                  label: l10n.dashboard,
                ),
                _buildNavItem(
                  context,
                  index: 1,
                  icon: Icons.swap_horiz_outlined,
                  selectedIcon: Icons.swap_horiz,
                  label: l10n.transactions,
                ),
                _buildNavItem(
                  context,
                  index: 2,
                  icon: Icons.receipt_long_outlined,
                  selectedIcon: Icons.receipt_long,
                  label: l10n.invoices,
                ),
                _buildNavItem(
                  context,
                  index: 3,
                  icon: Icons.qr_code_scanner_outlined,
                  selectedIcon: Icons.qr_code_scanner,
                  label: l10n.barcodeReader,
                ),
                _buildNavItem(
                  context,
                  index: 4,
                  icon: Icons.bar_chart_outlined,
                  selectedIcon: Icons.bar_chart,
                  label: l10n.reports,
                ),
                _buildNavItem(
                  context,
                  index: 5,
                  icon: Icons.people_outline,
                  selectedIcon: Icons.people,
                  label: l10n.customers,
                ),
                _buildNavItem(
                  context,
                  index: 6,
                  icon: Icons.store_outlined,
                  selectedIcon: Icons.store,
                  label: l10n.vendors,
                ),
                _buildNavItem(
                  context,
                  index: 7,
                  icon: Icons.inventory_2_outlined,
                  selectedIcon: Icons.inventory_2,
                  label: l10n.products,
                ),
                _buildNavItem(
                  context,
                  index: 8,
                  icon: Icons.notifications_none_outlined,
                  selectedIcon: Icons.notifications,
                  label: l10n.reminders,
                ),
                _buildNavItem(
                  context,
                  index: 9,
                  icon: Icons.support_agent_outlined,
                  selectedIcon: Icons.support_agent,
                  label: l10n.support,
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: _buildNavItem(
              context,
              index: 10,
              icon: Icons.settings_outlined,
              selectedIcon: Icons.settings,
              label: l10n.settings,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required IconData selectedIcon,
    required String label,
  }) {
    final isSelected = selectedIndex == index;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => onDestinationSelected(index),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? colorScheme.primary.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isSelected
                  ? Border.all(
                      color: colorScheme.primary.withValues(alpha: 0.2),
                    )
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isSelected ? selectedIcon : icon,
                  color: isSelected
                      ? colorScheme.primary
                      : Theme.of(context).unselectedWidgetColor,
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected
                        ? colorScheme.primary
                        : Theme.of(context).textTheme.bodySmall?.color,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 10, // Smaller font for vertical layout
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
