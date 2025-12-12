import 'package:equatable/equatable.dart';
import '../../domain/entities/language_entity.dart';

sealed class LanguageState extends Equatable {
  const LanguageState();
}

class LanguageInitial extends LanguageState {
  const LanguageInitial();

  @override
  List<Object?> get props => [];
}

class LanguageLoading extends LanguageState {
  const LanguageLoading();

  @override
  List<Object?> get props => [];
}

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
