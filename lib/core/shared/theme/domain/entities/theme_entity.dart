import 'package:equatable/equatable.dart';

enum ThemeType {
  light,
  dark,
}

class ThemeEntity extends Equatable {
  final ThemeType type;

  const ThemeEntity({required this.type});

  @override
  List<Object?> get props => [type];
}
