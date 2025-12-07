import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/shared/currency/data/data_sources/currency_local_data_source.dart';
import 'package:orbiq/core/shared/currency/data/repositories/currency_repository_impl.dart';
import 'package:orbiq/core/shared/currency/presentation/controller/currency_bloc.dart';
import 'package:orbiq/core/shared/currency/presentation/controller/currency_event.dart';

List<BlocProvider> currencyBlocProviders() {
  final currencyLocalDataSource = CurrencyLocalDataSource();
  final currencyRepository = CurrencyRepositoryImpl(currencyLocalDataSource);

  return [
    BlocProvider<CurrencyBloc>(
      create: (context) =>
          CurrencyBloc(repository: currencyRepository)
            ..add(LoadCurrencySettings()),
    ),
  ];
}
