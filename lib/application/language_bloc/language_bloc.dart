import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/core.dart';
import '../../data/data.dart';

part 'language_event.dart';
part 'language_state.dart';

const kDefaultLocale = Locale('ru');

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState()) {
    on<LanguageInitial>(_onLanguageInitial);
    on<LanguageChanged>(_onLanguageChanged);
  }

  FutureOr<void> _onLanguageChanged(LanguageChanged event, Emitter<LanguageState> emit) async {
    final ctx = event.context;
    if (!ctx.mounted) return;

    final lang = event.lang;

    final locale = Locale(lang.code, lang.countryCode);

    await ctx.setLocale(locale);

    emit(state.copyWith(locale: locale));

    /// Keep in shared preference
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(activeLang, lang.code);
  }

  FutureOr<void> _onLanguageInitial(LanguageInitial event, Emitter<LanguageState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString(activeLang) ?? 'tr';

    final lang = languages.where((l) => l.code == langCode).first;

    emit(
      state.copyWith(
        locale: Locale(lang.code, lang.countryCode),
      ),
    );
  }
}
