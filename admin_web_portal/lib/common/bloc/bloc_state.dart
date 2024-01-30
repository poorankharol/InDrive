import 'package:flutter/foundation.dart' show immutable;

import 'bloc_status.dart';

@immutable
class BlocState<T> {
  final T? data;
  final String? error;
  final BlocStatus status;

  const BlocState({this.data, this.error, required this.status});

  factory BlocState.initial() => const BlocState(status: BlocStatus.initial);

  factory BlocState.loading() => const BlocState(status: BlocStatus.loading);

  factory BlocState.failure(String error) =>
      BlocState(error: error, status: BlocStatus.failure);

  factory BlocState.success({T? data}) =>
      BlocState(data: data, status: BlocStatus.success);

  factory BlocState.noInternet(String error) =>
      BlocState(error: error, status: BlocStatus.noInternet);
}
