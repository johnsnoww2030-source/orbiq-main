import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/adaptor/routes_constants.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_bloc.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_event.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_state.dart';
import 'package:orbiq/features/auth/presentation/ui/user_management_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Password change controllers
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is PasswordUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('رمز عبور با موفقیت تغییر یافت'),
              backgroundColor: Colors.green,
            ),
          );
          _clearPasswordFields();
          Navigator.of(context).pop();
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.settings,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'مدیریت حساب کاربری و تنظیمات برنامه',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: colorScheme.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  labelColor: colorScheme.primary,
                  unselectedLabelColor: Colors.grey,
                  dividerColor: Colors.transparent,
                  tabs: [
                    _buildTab(Icons.settings, 'عمومی'),
                    _buildTab(Icons.person_outline, 'پروفایل'),
                    _buildTab(Icons.security_outlined, 'امنیت'),
                    _buildTab(Icons.people_outline, 'کاربران'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildGeneralTab(context, l10n),
                    _buildProfileTab(context, l10n),
                    _buildSecurityTab(context, l10n),
                    _buildUsersTab(context, l10n),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(IconData icon, String label) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(icon, size: 20), const SizedBox(width: 8), Text(label)],
      ),
    );
  }

  Widget _buildGeneralTab(BuildContext context, AppLocalizations l10n) {
    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تنظیمات عمومی',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'تنظیمات زبان و واحد پول برنامه',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              _buildSecurityItem(
                context,
                icon: Icons.language,
                title: l10n.language,
                subtitle: 'زبان برنامه را انتخاب کنید',
                actionLabel: 'تغییر',
                onAction: () =>
                    Navigator.pushNamed(context, Routes.languageSettings),
              ),
              const Divider(height: 32),
              _buildSecurityItem(
                context,
                icon: Icons.attach_money,
                title: 'واحد پول',
                subtitle: 'واحد پول و نرخ تبدیل را مدیریت کنید',
                actionLabel: 'تغییر',
                onAction: () =>
                    Navigator.pushNamed(context, Routes.currencySettings),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileTab(BuildContext context, AppLocalizations l10n) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String username = '';
        String nickname = '';
        String role = '';

        if (state is AuthSuccess) {
          username = state.user.username;
          nickname = state.user.nickname;
          role = state.user.role;
        }

        return SingleChildScrollView(
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'اطلاعات پروفایل',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'اطلاعات شخصی و تصویر پروفایل خود را مدیریت کنید',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                          nickname.isNotEmpty ? nickname[0].toUpperCase() : 'U',
                          style: const TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.camera_alt_outlined),
                            label: const Text('تغییر تصویر'),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'JPG, PNG یا GIF. حداکثر 2MB',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(context, 'نام', nickname, false),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(
                          context,
                          'نام کاربری',
                          username,
                          false,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          context,
                          'نقش',
                          _getRoleLabel(role),
                          false,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FilledButton(
                      onPressed: () {},
                      child: const Text('ذخیره تغییرات'),
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

  Widget _buildSecurityTab(BuildContext context, AppLocalizations l10n) {
    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'امنیت',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'رمز عبور و تنظیمات امنیتی خود را مدیریت کنید',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              _buildSecurityItem(
                context,
                icon: Icons.lock_outline,
                title: 'رمز عبور',
                subtitle: 'آخرین تغییر: 30 روز پیش',
                actionLabel: 'تغییر رمز عبور',
                onAction: () => _showChangePasswordDialog(context),
              ),
              const Divider(height: 32),
              _buildSecurityItem(
                context,
                icon: Icons.security_outlined,
                title: 'احراز هویت دو مرحله‌ای',
                subtitle: 'امنیت بیشتر برای حساب شما',
                actionLabel: 'فعال‌سازی',
                onAction: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsersTab(BuildContext context, AppLocalizations l10n) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مدیریت کاربران',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'اپراتورها و نقش‌های دسترسی را مدیریت کنید',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                FilledButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserManagementPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.person_add),
                  label: const Text('مدیریت کاربران'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'کاربر',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'نقش',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'وضعیت',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'برای مدیریت کاربران دکمه بالا را بزنید',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String label,
    String value,
    bool enabled,
  ) {
    return TextFormField(
      initialValue: value,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: !enabled,
        fillColor: enabled ? null : Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }

  Widget _buildSecurityItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String actionLabel,
    required VoidCallback onAction,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Theme.of(context).primaryColor),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
        OutlinedButton(onPressed: onAction, child: Text(actionLabel)),
      ],
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          String? username;
          if (state is AuthSuccess) {
            username = state.user.username;
          }

          return AlertDialog(
            title: const Text('تغییر رمز عبور'),
            content: Form(
              key: _passwordFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _currentPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'رمز عبور فعلی',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'لطفاً رمز عبور فعلی را وارد کنید'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'رمز عبور جدید',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'لطفاً رمز عبور جدید را وارد کنید';
                      }
                      if (value.length < 6) {
                        return 'رمز عبور باید حداقل 6 کاراکتر باشد';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'تکرار رمز عبور جدید',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value != _newPasswordController.text) {
                        return 'رمز عبور تکرار شده مطابقت ندارد';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: isLoading
                    ? null
                    : () => Navigator.pop(dialogContext),
                child: const Text('انصراف'),
              ),
              FilledButton(
                onPressed: isLoading
                    ? null
                    : () {
                        if (_passwordFormKey.currentState!.validate() &&
                            username != null) {
                          context.read<AuthBloc>().add(
                            UpdatePasswordRequested(
                              username: username,
                              newPassword: _newPasswordController.text,
                            ),
                          );
                        }
                      },
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('ذخیره'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _clearPasswordFields() {
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
  }

  String _getRoleLabel(String role) {
    switch (role) {
      case 'admin':
        return 'مدیر';
      case 'manager':
        return 'مدیر';
      case 'seller':
        return 'فروشنده';
      default:
        return role;
    }
  }
}
