import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/theme_entity.dart';

part 'theme_state.freezed.dart';

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState.initial() = ThemeInitial;
  const factory ThemeState.loading() = ThemeLoading;
  const factory ThemeState.loaded(ThemeEntity theme) = ThemeLoaded;
  const factory ThemeState.error(String message) = ThemeError;
}
