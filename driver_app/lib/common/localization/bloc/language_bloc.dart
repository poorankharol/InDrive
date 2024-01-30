import 'dart:async';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/error_messages.dart';
import '../constants/languages.dart';
import '../repository/language_repository.dart';
import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LanguageRepository _languageRepository;

  LanguageBloc(
    this._languageRepository,
  ) : super(const UpdateAppLanguage(Locale(Languages.english))) {
    on<FetchCurrentAppLanguage>(_fetchCurrentAppLanguage);
    on<SaveAppLanguage>(_saveAppLanguage);
    add(const FetchCurrentAppLanguage());
  }

  FutureOr<void> _fetchCurrentAppLanguage(
      FetchCurrentAppLanguage event, Emitter<LanguageState> emit) async {
    var appLanguageCode = await _languageRepository.fetchLocale();
    emit(UpdateAppLanguage(Locale(appLanguageCode)));
  }

  FutureOr<void> _saveAppLanguage(
      SaveAppLanguage event, Emitter<LanguageState> emit) async {
    var isSavedSuccessfully = await _languageRepository
        .saveLocale(event.languageCode ?? Languages.english);
    isSavedSuccessfully
        ? emit(
            UpdateAppLanguage(Locale(event.languageCode ?? Languages.english)),
          )
        : emit(
            const AppLanguageUpdateFailed(
                ErrorMessages.appLanguageUpdateFailed),
          );
  }
}
