import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/shared/localization/domain/usecases/get_language_usecase.dart';
import 'package:orbiq/core/shared/localization/domain/usecases/save_language_usecase.dart';
import 'package:orbiq/core/shared/localization/presentation/controller/language_event.dart';
import 'package:orbiq/core/shared/localization/presentation/controller/language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final GetLanguageUseCase getLanguageUseCase;
  final SaveLanguageUseCase saveLanguageUseCase;

  LanguageBloc({
    required this.getLanguageUseCase,
    required this.saveLanguageUseCase,
  }) : super(LanguageInitial()) {
    on<GetLanguageEvent>(_onGetLanguage);
    on<ChangeLanguageEvent>(_onChangeLanguage);
  }

  Future<void> _onGetLanguage(
    GetLanguageEvent event,
    Emitter<LanguageState> emit,
  ) async {
    emit(LanguageLoading());
    final result = await getLanguageUseCase();
    result.fold(
      (failure) => emit(LanguageError(failure.toString())),
      (language) => emit(LanguageLoaded(language)),
    );
  }

  Future<void> _onChangeLanguage(
    ChangeLanguageEvent event,
    Emitter<LanguageState> emit,
  ) async {
    emit(LanguageLoading());
    final result = await saveLanguageUseCase(event.language);
    result.fold(
      (failure) => emit(LanguageError(failure.toString())),
      (_) => emit(LanguageLoaded(event.language)),
    );
  }
}
