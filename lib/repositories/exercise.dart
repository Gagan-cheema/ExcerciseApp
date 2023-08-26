import 'package:exercise_app/constants/endpoints.dart';
import 'package:exercise_app/models/exercise.dart';
import 'package:exercise_app/models/exercise_details.dart';
import 'package:exercise_app/services/api_service.dart';

class ExerciseRepository {
  final _apiService = ApiService();

  Future<List<Exercise>> getExercises() async {
    final response = await _apiService.get(Endpoint.exercises);
    return (response.data as List).map((e) => Exercise.fromJson(e)).toList();
  }

  Future<ExerciseDetails> getExerciseDetails(String? id) async {
    final response = await _apiService.get("${Endpoint.exercise}$id");
    return ExerciseDetails.fromJson(response.data);
  }
}
