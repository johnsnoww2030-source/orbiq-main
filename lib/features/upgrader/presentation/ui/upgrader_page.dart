import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/features/upgrader/presentation/controllers/bloc/update_bloc.dart';
import 'package:orbiq/features/upgrader/presentation/controllers/bloc/update_event.dart';
import 'package:orbiq/features/upgrader/presentation/controllers/bloc/update_state.dart';

class UpgraderPage extends StatelessWidget {
  const UpgraderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' به‌روزرسانی'),
      ),
      body: Center(
        child: BlocBuilder<UpdateBloc, UpdateState>(
          builder: (context, state) {
            if (state is UpdateInitial) {
              return ElevatedButton(
                child: const Text('بررسی به‌روزرسانی'),
                onPressed: () {
                  context.read<UpdateBloc>().add(CheckForUpdateEvent());
                },
              );
            } else if (state is UpdateChecking) {
              return const CircularProgressIndicator();
            } else if (state is UpdateAvailable) {
              return ElevatedButton(
                child: const Text('دانلود و نصب نسخه جدید'),
                onPressed: () {
                  context
                      .read<UpdateBloc>()
                      .add(DownloadAndInstallUpdateEvent(state.versionInfo));
                },
              );
            } else if (state is UpdateNotAvailable) {
              return const Text('نرم‌افزار شما به‌روز است');
            } else if (state is UpdateDownloading) {
              return const Text('در حال دانلود و نصب به‌روزرسانی...');
            } else if (state is UpdateInstalled) {
              return const Text(
                  'به‌روزرسانی با موفقیت نصب شد. لطفاً برنامه را مجدداً اجرا کنید.');
            } else if (state is UpdateError) {
              return Text('خطا: ${state.message}');
            }
            return Container();
          },
        ),
      ),
    );
  }
}
