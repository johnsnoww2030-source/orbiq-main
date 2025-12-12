import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/di/injection.dart';
import 'package:orbiq/features/sales/presentation/controller/sales_bloc.dart';

/// BlocProvider for SalesBloc
final salesBlocProviders = [
  BlocProvider<SalesBloc>(create: (_) => getIt<SalesBloc>()),
];
