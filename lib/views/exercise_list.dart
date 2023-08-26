import 'package:exercise_app/constants/constants.dart';
import 'package:exercise_app/controllers/exercise.dart';
import 'package:exercise_app/utils/state_handler.dart';
import 'package:exercise_app/views/exercise_details.dart';
import 'package:exercise_app/widgets/placeholder.dart';
import 'package:exercise_app/widgets/popups.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExerciseList extends StatefulWidget {
  const ExerciseList({super.key});

  @override
  State<ExerciseList> createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  final _controller = Get.put(ExerciseController());
  Worker? _everListenter;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _controller.getExercises();
      _initializeStateListener();
    });
    super.initState();
  }

  void _initializeStateListener() {
    _everListenter = ever(_controller.state, (state) {
      if (state == ExerciseState.failure) {
        Popup.showErrorDialog(context, message: _controller.message);
      }
    });
  }

  @override
  void dispose() {
    _everListenter?.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppName),
        backgroundColor: theme.colorScheme.inversePrimary,
      ),
      body: RefreshIndicator(
        onRefresh: _controller.getExercises,
        child: Obx(
          () {
            return whenState(
              _controller.state.value,
              onLoading: () => const Center(child: CircularProgressIndicator()),
              onFailure: () => const FailurePlaceHolder(),
              onSuccess: () => ListView.builder(
                itemCount: _controller.exerciseList.length,
                itemBuilder: (context, index) {
                  final exercise = _controller.exerciseList[index];

                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciseDetails(exercise.id),
                        ),
                      );
                    },
                    title: Text(
                      '${exercise.name?.capitalizeFirst}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: theme.colorScheme.inversePrimary,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

