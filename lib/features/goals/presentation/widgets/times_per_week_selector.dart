import 'package:flutter/material.dart';

class TimesPerWeekSelector extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const TimesPerWeekSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: value > 1 ? () => onChanged(value - 1) : null,
          icon: const Icon(Icons.remove),
        ),
        Text(
          '$value times / week',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        IconButton(
          onPressed: () => onChanged(value + 1),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
