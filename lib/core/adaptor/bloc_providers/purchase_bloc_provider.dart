import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/di/injection.dart';
import 'package:orbiq/features/purchase/presentation/controller/purchase_bloc.dart';

/// Provides PurchaseBloc for the app
List<BlocProvider> purchaseBlocProviders = [
  BlocProvider<PurchaseBloc>(create: (_) => getIt<PurchaseBloc>()),
];
