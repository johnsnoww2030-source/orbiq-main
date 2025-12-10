import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/theme_entity.dart';
import '../../domain/usecases/get_theme_usecase.dart';
import '../../domain/usecases/save_theme_usecase.dart';
import 'theme_event.dart';
import 'theme_state.dart';
import '../../../../utils/usecase/usecase.dart';

@injectable
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetThemeUseCase getThemeUseCase;
  final SaveThemeUseCase saveThemeUseCase;

  ThemeBloc({required this.getThemeUseCase, required this.saveThemeUseCase})
    : super(const ThemeState.initial()) {
    on<GetThemeEvent>(_onGetTheme);
    on<ToggleThemeEvent>(_onToggleTheme);
    on<SetThemeEvent>(_onSetTheme);
  }

  Future<void> _onGetTheme(
    GetThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    emit(const ThemeState.loading());
    final result = await getThemeUseCase(NoParams());
    result.fold(
      (failure) => emit(const ThemeState.error('خطا در بارگیری تم')),
      (theme) => emit(ThemeState.loaded(theme)),
    );
  }

  Future<void> _onToggleTheme(
    ToggleThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    state.mapOrNull(
      loaded: (loadedState) async {
        final currentTheme = loadedState.theme;
        final newThemeType = currentTheme.type == ThemeType.light
            ? ThemeType.dark
            : ThemeType.light;

        final newTheme = ThemeEntity(type: newThemeType);

        emit(const ThemeState.loading());
        final result = await saveThemeUseCase(newTheme);
        result.fold(
          (failure) => emit(const ThemeState.error('خطا در ذخیره تم')),
          (_) => emit(ThemeState.loaded(newTheme)),
        );
      },
    );
  }

  Future<void> _onSetTheme(
    SetThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final newTheme = ThemeEntity(type: event.themeType);

    emit(const ThemeState.loading());
    final result = await saveThemeUseCase(newTheme);
    result.fold(
      (failure) => emit(const ThemeState.error('خطا در ذخیره تم')),
      (_) => emit(ThemeState.loaded(newTheme)),
    );
  }
}
