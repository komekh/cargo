part of 'language_bloc.dart';

sealed class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

final class LanguageInitial extends LanguageEvent {}

final class LanguageChanged extends LanguageEvent {
  final Language lang;
  final BuildContext context;

  const LanguageChanged({required this.lang, required this.context});

  @override
  List<Object> get props => [lang, context];
}
