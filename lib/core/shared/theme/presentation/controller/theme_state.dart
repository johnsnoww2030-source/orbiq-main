import 'package:equatable/equatable.dart';
import '../../domain/entities/theme_entity.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();
}

class ThemeInitial extends ThemeState {
  const ThemeInitial();

  @override
  List<Object?> get props => [];
}

class ThemeLoading extends ThemeState {
  const ThemeLoading();

  @override
  List<Object?> get props => [];
}

class ThemeLoaded extends ThemeState {
  final ThemeEntity theme;

  const ThemeLoaded(this.theme);

  @override
  List<Object?> get props => [theme];
}

class ThemeError extends ThemeState {
  final String message;

  const ThemeError(this.message);

  @override
  List<Object?> get props => [message];
}
