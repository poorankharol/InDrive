import 'package:flutter_bloc/flutter_bloc.dart';

extension BlocReset on Bloc {
  void reset(dynamic initialState) {
    // ignore: invalid_use_of_visible_for_testing_member
    emit(initialState);
  }
}
