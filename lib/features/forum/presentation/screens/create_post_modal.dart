import 'package:flutter/material.dart';
import 'package:fit_tracker/features/forum/data/datasources/mock_forum.dart';
import 'package:fit_tracker/features/forum/presentation/controllers/forum_controller.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';

class CreatePostModal extends StatefulWidget {
  final ForumController controller;

  const CreatePostModal({super.key, required this.controller});

  @override
  State<CreatePostModal> createState() => _CreatePostModalState();
}

class _CreatePostModalState extends State<CreatePostModal> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  late TextEditingController tagsController;
  String? selectedCategory;
  final List<String> tagSuggestions = [
    'beginner',
    'advanced',
    'workout',
    'nutrition',
    'recovery',
    'mindset',
    'motivation',
    'tips',
    'challenge',
    'routine',
  ];
  final Set<String> selectedTags = {};

  final Map<String, IconData> categoryIcons = {
    'General': Icons.public,
    'Fitness': Icons.fitness_center,
    'Nutrition': Icons.restaurant,
    'Mental Health': Icons.psychology,
  };

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
    tagsController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 24.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Create New Post',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.brandPrimary,
                    ),
              ),
              const SizedBox(height: 24),

              // Title Field
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: const TextStyle(color: AppColors.brandPrimary),
                  hintText: 'What do you want to discuss?',
                  filled: true,
                  fillColor: Colors.grey[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.grayLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.brandPrimary,
                      width: 2,
                    ),
                  ),
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),

              // Content Field
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                  labelText: 'Content',
                  labelStyle: const TextStyle(color: AppColors.brandPrimary),
                  hintText: 'Share your thoughts...',
                  filled: true,
                  fillColor: Colors.grey[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.grayLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.brandPrimary,
                      width: 2,
                    ),
                  ),
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 20),

              // Category Selection with Icons
              Text(
                'Category',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.brandPrimary,
                    ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: MockForum.categories.map((category) {
                    final isSelected = selectedCategory == category.name;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            selectedCategory = selected ? category.name : null;
                          });
                        },
                        avatar: Icon(
                          categoryIcons[category.name] ?? Icons.category,
                          size: 18,
                          color: isSelected
                              ? AppColors.white
                              : AppColors.brandPrimary,
                        ),
                        label: Text(category.name),
                        backgroundColor: Colors.grey[200],
                        selectedColor: AppColors.brandPrimary,
                        labelStyle: TextStyle(
                          color: isSelected ? AppColors.white : AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),

              // Tags Section
              Text(
                'Tags',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.brandPrimary,
                    ),
              ),
              const SizedBox(height: 12),

              // Tag Input Field
              TextField(
                controller: tagsController,
                decoration: InputDecoration(
                  labelText: 'Add tags',
                  labelStyle: const TextStyle(color: AppColors.brandPrimary),
                  hintText: 'Type a tag and press space',
                  filled: true,
                  fillColor: Colors.grey[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.grayLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.brandPrimary,
                      width: 2,
                    ),
                  ),
                  suffixIcon: selectedTags.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear,
                              color: AppColors.brandPrimary),
                          onPressed: () {
                            setState(() {
                              selectedTags.clear();
                              tagsController.clear();
                            });
                          },
                        )
                      : null,
                ),
                onChanged: (value) {
                  setState(() {});
                },
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    setState(() {
                      selectedTags.add(value.trim().toLowerCase());
                      tagsController.clear();
                    });
                  }
                },
              ),
              const SizedBox(height: 12),

              // Selected Tags Display
              if (selectedTags.isNotEmpty)
                Wrap(
                  spacing: 8,
                  children: selectedTags
                      .map((tag) => Chip(
                            label: Text(tag),
                            backgroundColor: AppColors.brandPrimary,
                            labelStyle: const TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            deleteIcon: const Icon(Icons.close,
                                color: AppColors.white, size: 18),
                            onDeleted: () {
                              setState(() {
                                selectedTags.remove(tag);
                              });
                            },
                          ))
                      .toList(),
                ),
              if (selectedTags.isNotEmpty) const SizedBox(height: 12),

              // Tag Suggestions - Always Visible
              Wrap(
                spacing: 8,
                children: tagSuggestions
                    .where((tag) => !selectedTags.contains(tag))
                    .map((tag) => ActionChip(
                          label: Text(tag),
                          backgroundColor: Colors.grey[100],
                          labelStyle: const TextStyle(
                            color: AppColors.brandPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                          onPressed: () {
                            setState(() {
                              selectedTags.add(tag);
                            });
                          },
                        ))
                    .toList(),
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (titleController.text.isEmpty ||
                          contentController.text.isEmpty ||
                          selectedCategory == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please fill in title, content, and category',
                            ),
                            backgroundColor: AppColors.brandPrimary,
                          ),
                        );
                        return;
                      }
                      await widget.controller.createPost(
                        titleController.text,
                        contentController.text,
                        selectedCategory!,
                        selectedTags.toList(),
                      );

                      // Check for errors
                      if (widget.controller.errorMessage != null &&
                          context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(widget.controller.errorMessage ?? ''),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      if (context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Post created successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Post',
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
