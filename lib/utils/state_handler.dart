import 'package:exercise_app/controllers/exercise.dart';
import 'package:flutter/widgets.dart';


Widget whenState(
  ExerciseState state, {
  Widget Function()? onInitial,
  Widget Function()? onLoading,
  required Widget Function() onSuccess,
  Widget Function()? onFailure,
}) {
  switch (state) {
    case ExerciseState.initial:
      return onInitial?.call() ?? const SizedBox();
    case ExerciseState.loading:
      return onLoading?.call() ?? const SizedBox();
    case ExerciseState.success:
      return onSuccess.call();
    case ExerciseState.failure:
      return onFailure?.call() ?? const SizedBox();
  }
}
