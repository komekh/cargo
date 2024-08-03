part of 'language_bloc.dart';

class LanguageState extends Equatable {
  final Locale locale;
  const LanguageState({
    this.locale = const Locale('tr', 'TR'),
  });

  @override
  List<Object?> get props => [locale];

  LanguageState copyWith({
    Locale? locale,
  }) {
    return LanguageState(
      locale: locale ?? this.locale,
    );
  }
}
