import 'package:flutter/material.dart';
import '../model/model.dart';

// Container for recipe time
class TimeContainer extends StatelessWidget {
  const TimeContainer({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      const Icon(
        Icons.access_alarm_outlined,
        size: 18,
      ),
      const SizedBox(width: 3),
      Text(recipe.time.toString()),
    ]);
  }
}
