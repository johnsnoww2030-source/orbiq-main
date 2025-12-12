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
    : super(const ThemeInitial()) {
    on<GetThemeEvent>(_onGetTheme);
    on<ToggleThemeEvent>(_onToggleTheme);
    on<SetThemeEvent>(_onSetTheme);
  }

  Future<void> _onGetTheme(
    GetThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    emit(const ThemeLoading());
    final result = await getThemeUseCase(NoParams());
    result.fold(
      (failure) => emit(const ThemeError('خطا در بارگیری تم')),
      (theme) => emit(ThemeLoaded(theme)),
    );
  }

  Future<void> _onToggleTheme(
    ToggleThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ThemeLoaded) return;

    final currentTheme = currentState.theme;
    final newThemeType = currentTheme.type == ThemeType.light
        ? ThemeType.dark
        : ThemeType.light;

    final newTheme = ThemeEntity(type: newThemeType);

    emit(const ThemeLoading());
    final result = await saveThemeUseCase(newTheme);
    result.fold(
      (failure) => emit(const ThemeError('خطا در ذخیره تم')),
      (_) => emit(ThemeLoaded(newTheme)),
    );
  }

  Future<void> _onSetTheme(
    SetThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final newTheme = ThemeEntity(type: event.themeType);

    emit(const ThemeLoading());
    final result = await saveThemeUseCase(newTheme);
    result.fold(
      (failure) => emit(const ThemeError('خطا در ذخیره تم')),
      (_) => emit(ThemeLoaded(newTheme)),
    );
  }
}
