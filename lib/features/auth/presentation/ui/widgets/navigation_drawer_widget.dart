import 'package:flutter/material.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';

class NavigationDrawerWidget extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const NavigationDrawerWidget({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget>
    with TickerProviderStateMixin {
  bool _isSalesExpanded = false;
  bool _isInventoryExpanded = false;

  @override
  void initState() {
    super.initState();
    // Auto-expand sections if a child is selected
    if (widget.selectedIndex == 1 || widget.selectedIndex == 2) {
      _isSalesExpanded = true;
    }
    if (widget.selectedIndex >= 3 && widget.selectedIndex <= 6) {
      _isInventoryExpanded = true;
    }
  }

  @override
  void didUpdateWidget(NavigationDrawerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Auto-expand when navigating to child items
    if (widget.selectedIndex == 1 || widget.selectedIndex == 2) {
      _isSalesExpanded = true;
    }
    if (widget.selectedIndex >= 3 && widget.selectedIndex <= 6) {
      _isInventoryExpanded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 88,
      decoration: BoxDecoration(
        color: isDark
            ? colorScheme.surface.withValues(alpha: 0.95)
            : colorScheme.surface,
        border: Border(
          left: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          // App Logo
          _buildLogo(context, colorScheme),
          const SizedBox(height: 12),
          _buildDivider(colorScheme),

          // Scrollable Menu Items
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                children: [
                  // Dashboard
                  _buildNavItem(
                    context,
                    index: 0,
                    icon: Icons.grid_view_rounded,
                    selectedIcon: Icons.grid_view_rounded,
                    label: l10n.dashboard,
                  ),

                  const SizedBox(height: 4),

                  // Sales (expandable)
                  _buildExpandableNavItem(
                    context,
                    icon: Icons.storefront_outlined,
                    selectedIcon: Icons.storefront_rounded,
                    label: l10n.sales,
                    isExpanded: _isSalesExpanded,
                    onExpandTap: () {
                      setState(() {
                        _isSalesExpanded = !_isSalesExpanded;
                      });
                    },
                    isAnyChildSelected:
                        widget.selectedIndex == 1 || widget.selectedIndex == 2,
                    children: [
                      _buildSubNavItem(
                        context,
                        index: 1,
                        icon: Icons.receipt_outlined,
                        selectedIcon: Icons.receipt_rounded,
                        label: l10n.salesInvoices,
                      ),
                      _buildSubNavItem(
                        context,
                        index: 2,
                        icon: Icons.people_alt_outlined,
                        selectedIcon: Icons.people_alt_rounded,
                        label: l10n.customers,
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Inventory & Procurement (expandable)
                  _buildExpandableNavItem(
                    context,
                    icon: Icons.inventory_2_outlined,
                    selectedIcon: Icons.inventory_2_rounded,
                    label: l10n.inventoryAndProcurement,
                    isExpanded: _isInventoryExpanded,
                    onExpandTap: () {
                      setState(() {
                        _isInventoryExpanded = !_isInventoryExpanded;
                      });
                    },
                    isAnyChildSelected:
                        widget.selectedIndex >= 3 && widget.selectedIndex <= 6,
                    children: [
                      _buildSubNavItem(
                        context,
                        index: 3,
                        icon: Icons.view_list_outlined,
                        selectedIcon: Icons.view_list_rounded,
                        label: l10n.productList,
                      ),
                      _buildSubNavItem(
                        context,
                        index: 4,
                        icon: Icons.shopping_bag_outlined,
                        selectedIcon: Icons.shopping_bag_rounded,
                        label: l10n.purchaseInvoices,
                      ),
                      _buildSubNavItem(
                        context,
                        index: 5,
                        icon: Icons.local_shipping_outlined,
                        selectedIcon: Icons.local_shipping_rounded,
                        label: l10n.suppliers,
                      ),
                      _buildSubNavItem(
                        context,
                        index: 6,
                        icon: Icons.inventory_outlined,
                        selectedIcon: Icons.inventory_rounded,
                        label: l10n.stocktaking,
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Reports
                  _buildNavItem(
                    context,
                    index: 7,
                    icon: Icons.analytics_outlined,
                    selectedIcon: Icons.analytics_rounded,
                    label: l10n.reports,
                  ),
                ],
              ),
            ),
          ),

          _buildDivider(colorScheme),

          // Settings at bottom
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: _buildNavItem(
              context,
              index: 8,
              icon: Icons.settings_outlined,
              selectedIcon: Icons.settings_rounded,
              label: l10n.settings,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo(BuildContext context, ColorScheme colorScheme) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            colorScheme.primary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(Icons.grid_view_rounded, color: Colors.white, size: 24),
    );
  }

  Widget _buildDivider(ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            colorScheme.outline.withValues(alpha: 0.15),
            Colors.transparent,
          ],
        ),
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
    final isSelected = widget.selectedIndex == index;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () => widget.onDestinationSelected(index),
          borderRadius: BorderRadius.circular(12),
          hoverColor: colorScheme.primary.withValues(alpha: 0.05),
          splashColor: colorScheme.primary.withValues(alpha: 0.1),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            decoration: BoxDecoration(
              color: isSelected
                  ? colorScheme.primary.withValues(alpha: 0.12)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? colorScheme.primary.withValues(alpha: 0.25)
                    : Colors.transparent,
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    isSelected ? selectedIcon : icon,
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.onSurface.withValues(alpha: 0.6),
                    size: isSelected ? 24 : 22,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.onSurface.withValues(alpha: 0.7),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 10,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableNavItem(
    BuildContext context, {
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required bool isExpanded,
    required VoidCallback onExpandTap,
    required bool isAnyChildSelected,
    required List<Widget> children,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Parent item
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: onExpandTap,
              borderRadius: BorderRadius.circular(12),
              hoverColor: colorScheme.primary.withValues(alpha: 0.05),
              splashColor: colorScheme.primary.withValues(alpha: 0.1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 4,
                ),
                decoration: BoxDecoration(
                  color: isAnyChildSelected
                      ? colorScheme.primary.withValues(alpha: 0.06)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isAnyChildSelected
                        ? colorScheme.primary.withValues(alpha: 0.12)
                        : Colors.transparent,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isAnyChildSelected ? selectedIcon : icon,
                      color: isAnyChildSelected
                          ? colorScheme.primary
                          : colorScheme.onSurface.withValues(alpha: 0.6),
                      size: 22,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      label,
                      style: TextStyle(
                        color: isAnyChildSelected
                            ? colorScheme.primary
                            : colorScheme.onSurface.withValues(alpha: 0.7),
                        fontWeight: isAnyChildSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                        fontSize: 9,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: colorScheme.onSurface.withValues(alpha: 0.4),
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Children with animation
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: isExpanded
              ? Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: children,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildSubNavItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required IconData selectedIcon,
    required String label,
  }) {
    final isSelected = widget.selectedIndex == index;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () => widget.onDestinationSelected(index),
          borderRadius: BorderRadius.circular(10),
          hoverColor: colorScheme.primary.withValues(alpha: 0.08),
          splashColor: colorScheme.primary.withValues(alpha: 0.12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            decoration: BoxDecoration(
              color: isSelected
                  ? colorScheme.primary.withValues(alpha: 0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected
                    ? colorScheme.primary.withValues(alpha: 0.3)
                    : Colors.transparent,
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSelected ? selectedIcon : icon,
                  color: isSelected
                      ? colorScheme.primary
                      : colorScheme.onSurface.withValues(alpha: 0.55),
                  size: isSelected ? 20 : 18,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.onSurface.withValues(alpha: 0.65),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 8,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
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
