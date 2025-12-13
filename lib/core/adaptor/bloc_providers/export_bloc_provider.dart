import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/di/injection.dart';
import 'package:orbiq/features/exports/presentation/controller/export_bloc.dart';

/// Provides ExportBloc using getIt for dependency injection
List<BlocProvider> exportBlocProviders() {
  return [BlocProvider<ExportBloc>(create: (_) => getIt<ExportBloc>())];
}
