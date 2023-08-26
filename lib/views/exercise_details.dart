import 'package:exercise_app/constants/constants.dart';
import 'package:exercise_app/controllers/exercise.dart';
import 'package:exercise_app/utils/state_handler.dart';
import 'package:exercise_app/widgets/placeholder.dart';
import 'package:exercise_app/widgets/popups.dart';
import 'package:exercise_app/widgets/tiles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExerciseDetails extends StatefulWidget {
  final String? id;

  const ExerciseDetails(this.id, {super.key});

  @override
  State<ExerciseDetails> createState() => _ExerciseDetailsState();
}

class _ExerciseDetailsState extends State<ExerciseDetails> {
  final controller = Get.put(ExerciseController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getExerciseDetails(widget.id);
      _initializeStateListener();
    });
    super.initState();
  }

  void _initializeStateListener() {
    ever(controller.state, (state) {
      if (state == ExerciseState.failure) {
        Popup.showErrorDialog(context, message: controller.message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(kExerciseDetails),
        backgroundColor: theme.colorScheme.inversePrimary,
      ),
      body: Obx(
        () {
          return whenState(
            controller.state.value,
            onLoading: () => const Center(child: CircularProgressIndicator()),
            onFailure: () => const FailurePlaceHolder(),
            onSuccess: () {
              final exercise = controller.exerciseDetails.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.all(16.0),
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: FadeInImage.assetNetwork(
                        image: exercise.gifUrl ?? '',
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholderScale: 4,
                        placeholder: kPlaceholderImage,
                        placeholderFit: BoxFit.scaleDown,
                        imageErrorBuilder: (_, __, ___) => Image.asset(
                          kErrorImage,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exercise.name?.capitalizeFirst ?? '',
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextTile(
                            title: kTarget,
                            subTitle: '${exercise.target?.capitalizeFirst}',
                          ),
                          TextTile(
                            title: kBodyPart,
                            subTitle: '${exercise.bodyPart?.capitalizeFirst}',
                          ),
                          TextTile(
                            title: kEquipment,
                            subTitle: '${exercise.equipment?.capitalizeFirst}',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
