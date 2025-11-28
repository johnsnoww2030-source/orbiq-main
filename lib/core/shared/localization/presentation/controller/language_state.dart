import 'package:equatable/equatable.dart';
import 'package:orbiq/core/shared/localization/domain/entities/language_entity.dart';

abstract class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object?> get props => [];
}

class LanguageInitial extends LanguageState {}

class LanguageLoading extends LanguageState {}

class LanguageLoaded extends LanguageState {
  final LanguageEntity language;

  const LanguageLoaded(this.language);

  @override
  List<Object?> get props => [language];
}

class LanguageError extends LanguageState {
  final String message;

  const LanguageError(this.message);

  @override
  List<Object?> get props => [message];
}
