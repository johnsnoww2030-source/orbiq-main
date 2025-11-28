import 'package:equatable/equatable.dart';

enum LanguageCode {
  en,
  fa,
}

class LanguageEntity extends Equatable {
  final LanguageCode code;
  final String name;

  const LanguageEntity({
    required this.code,
    required this.name,
  });

  @override
  List<Object?> get props => [code, name];

  static LanguageEntity persian() {
    return const LanguageEntity(
      code: LanguageCode.fa,
      name: 'فارسی',
    );
  }

  static LanguageEntity english() {
    return const LanguageEntity(
      code: LanguageCode.en,
      name: 'English',
    );
  }
}
