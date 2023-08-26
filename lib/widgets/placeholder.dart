
import 'package:exercise_app/constants/constants.dart';
import 'package:flutter/material.dart';

class FailurePlaceHolder extends StatelessWidget {
  const FailurePlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            kErrorImage,
            height: 200,
          ),
          const SizedBox(height: 20.0),
          Text(
            kSomethingNotRight,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}