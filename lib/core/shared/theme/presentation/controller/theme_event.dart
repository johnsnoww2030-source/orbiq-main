import 'package:equatable/equatable.dart';
import '../../domain/entities/theme_entity.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class GetThemeEvent extends ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {}

class SetThemeEvent extends ThemeEvent {
  final ThemeType themeType;

  const SetThemeEvent(this.themeType);

  @override
  List<Object?> get props => [themeType];
}
