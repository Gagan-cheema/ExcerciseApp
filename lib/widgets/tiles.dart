import 'package:flutter/material.dart';

class TextTile extends StatelessWidget {
  const TextTile({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 16.0, color: Colors.black),
        children: <TextSpan>[
          TextSpan(
            text: title,
            style: Theme.of(context).textTheme.bodyMedium?.apply(
                  fontWeightDelta: 1,
                ),
          ),
          TextSpan(
            text: subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
