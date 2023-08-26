import 'package:dio/dio.dart';
import 'package:exercise_app/constants/constants.dart';
import 'package:exercise_app/models/exercise.dart';
import 'package:exercise_app/models/exercise_details.dart';
import 'package:exercise_app/repositories/exercise.dart';
import 'package:get/get.dart';

enum ExerciseState { initial, loading, success, failure }

class ExerciseController extends GetxController {
  final _repository = ExerciseRepository();

  var message = '';
  var state = ExerciseState.initial.obs;
  var exerciseList = <Exercise>[].obs;
  var exerciseDetails = ExerciseDetails().obs;

  Future<void> getExercises() async {
    try {
      state.value = ExerciseState.loading;
      exerciseList.value = await _repository.getExercises();
      state.value = ExerciseState.success;
    } on DioException catch (e) {
      message = e.response?.statusMessage ?? e.message ?? kSomethingNotRight;
      state.value = ExerciseState.failure;
    } catch (e) {
      message = e.toString();
      state.value = ExerciseState.failure;
    }
  }

  Future<void> getExerciseDetails(String? id) async {
    try {
      state.value = ExerciseState.loading;
      exerciseDetails.value = await _repository.getExerciseDetails(id);
      state.value = ExerciseState.success;
    } on DioException catch (e) {
      message = e.response?.statusMessage ?? e.message ?? kSomethingNotRight;
      state.value = ExerciseState.failure;
    } catch (e) {
      message = e.toString();
      state.value = ExerciseState.failure;
    }
  }
}
