import 'package:equatable/equatable.dart';
import 'package:orbiq/core/shared/localization/domain/entities/language_entity.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object?> get props => [];
}

class GetLanguageEvent extends LanguageEvent {}

class ChangeLanguageEvent extends LanguageEvent {
  final LanguageEntity language;

  const ChangeLanguageEvent(this.language);

  @override
  List<Object?> get props => [language];
}
