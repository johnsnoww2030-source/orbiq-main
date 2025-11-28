import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/theme_entity.dart';
import '../../domain/usecases/get_theme_usecase.dart';
import '../../domain/usecases/save_theme_usecase.dart';
import 'theme_event.dart';
import 'theme_state.dart';
import '../../../../utils/usecase/usecase.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetThemeUseCase getThemeUseCase;
  final SaveThemeUseCase saveThemeUseCase;

  ThemeBloc({
    required this.getThemeUseCase,
    required this.saveThemeUseCase,
  }) : super(ThemeInitial()) {
    on<GetThemeEvent>(_onGetTheme);
    on<ToggleThemeEvent>(_onToggleTheme);
    on<SetThemeEvent>(_onSetTheme);
  }

  Future<void> _onGetTheme(
      GetThemeEvent event, Emitter<ThemeState> emit) async {
    emit(ThemeLoading());
    final result = await getThemeUseCase(NoParams());
    result.fold(
      (failure) => emit(const ThemeError('خطا در بارگیری تم')),
      (theme) => emit(ThemeLoaded(theme)),
    );
  }

  Future<void> _onToggleTheme(
      ToggleThemeEvent event, Emitter<ThemeState> emit) async {
    if (state is ThemeLoaded) {
      final currentTheme = (state as ThemeLoaded).theme;
      final newThemeType = currentTheme.type == ThemeType.light
          ? ThemeType.dark
          : ThemeType.light;

      final newTheme = ThemeEntity(type: newThemeType);

      emit(ThemeLoading());
      final result = await saveThemeUseCase(newTheme);
      result.fold(
        (failure) => emit(const ThemeError('خطا در ذخیره تم')),
        (_) => emit(ThemeLoaded(newTheme)),
      );
    }
  }

  Future<void> _onSetTheme(
      SetThemeEvent event, Emitter<ThemeState> emit) async {
    final newTheme = ThemeEntity(type: event.themeType);

    emit(ThemeLoading());
    final result = await saveThemeUseCase(newTheme);
    result.fold(
      (failure) => emit(const ThemeError('خطا در ذخیره تم')),
      (_) => emit(ThemeLoaded(newTheme)),
    );
  }
}
