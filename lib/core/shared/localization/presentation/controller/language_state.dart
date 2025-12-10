import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/language_entity.dart';

part 'language_state.freezed.dart';

@freezed
class LanguageState with _$LanguageState {
  const factory LanguageState.initial() = LanguageInitial;
  const factory LanguageState.loading() = LanguageLoading;
  const factory LanguageState.loaded(LanguageEntity language) = LanguageLoaded;
  const factory LanguageState.error(String message) = LanguageError;
}
