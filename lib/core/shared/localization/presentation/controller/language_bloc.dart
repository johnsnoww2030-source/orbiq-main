import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/core/shared/localization/domain/usecases/get_language_usecase.dart';
import 'package:orbiq/core/shared/localization/domain/usecases/save_language_usecase.dart';
import 'package:orbiq/core/shared/localization/presentation/controller/language_event.dart';
import 'package:orbiq/core/shared/localization/presentation/controller/language_state.dart';

@injectable
class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final GetLanguageUseCase getLanguageUseCase;
  final SaveLanguageUseCase saveLanguageUseCase;

  LanguageBloc({
    required this.getLanguageUseCase,
    required this.saveLanguageUseCase,
  }) : super(const LanguageState.initial()) {
    on<GetLanguageEvent>(_onGetLanguage);
    on<ChangeLanguageEvent>(_onChangeLanguage);
  }

  Future<void> _onGetLanguage(
    GetLanguageEvent event,
    Emitter<LanguageState> emit,
  ) async {
    emit(const LanguageState.loading());
    final result = await getLanguageUseCase();
    result.fold(
      (failure) => emit(LanguageState.error(failure.toString())),
      (language) => emit(LanguageState.loaded(language)),
    );
  }

  Future<void> _onChangeLanguage(
    ChangeLanguageEvent event,
    Emitter<LanguageState> emit,
  ) async {
    emit(const LanguageState.loading());
    final result = await saveLanguageUseCase(event.language);
    result.fold(
      (failure) => emit(LanguageState.error(failure.toString())),
      (_) => emit(LanguageState.loaded(event.language)),
    );
  }
}
