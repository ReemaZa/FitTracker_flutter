import 'package:fit_tracker/features/forum/data/datasources/mock_forum.dart';
import 'package:fit_tracker/features/forum/data/models/category.dart';
import 'package:flutter/material.dart';

class CategoryTabs extends StatelessWidget {
  final String selectedName;
  final ValueChanged<String> onSelect;

  const CategoryTabs(
      {super.key, required this.selectedName, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: MockForum.categories.map((category) {
          final isSelected = selectedName == category.name;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(category.name),
              selected: isSelected,
              onSelected: (_) => onSelect(category.name),
            ),
          );
        }).toList(),
      ),
    );
  }
}
