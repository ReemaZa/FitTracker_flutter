import 'package:fit_tracker/core/widgets/icon_button.dart';
import 'package:fit_tracker/features/forum/data/models/category.dart';
import 'package:fit_tracker/features/forum/domain/entities/forum_post.dart';
import 'package:fit_tracker/features/forum/presentation/controllers/forum_controller.dart';
import 'package:fit_tracker/features/forum/presentation/screens/create_post_modal.dart';
import 'package:fit_tracker/features/forum/presentation/widgets/category_tabs.dart';
import 'package:fit_tracker/features/forum/presentation/widgets/empty_state.dart';
import 'package:fit_tracker/features/forum/presentation/widgets/forum_header.dart';
import 'package:fit_tracker/features/forum/presentation/widgets/loading_view.dart';
import 'package:fit_tracker/features/forum/presentation/widgets/post_card.dart';
import 'package:flutter/material.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  late ForumController controller;

  @override
  void initState() {
    super.initState();
    controller = ForumController();
    controller.addListener(_onControllerChanged);
    controller.loadPosts();
  }

  void _onControllerChanged() {
    // Triggered when controller notifies listeners (posts loaded, category changed, etc.)
    setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerChanged);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ForumHeader(),
      body: ListenableBuilder(
        listenable: controller,
        builder: (_, __) {
          return Row(
            children: [
              /// MAIN CONTENT
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    CategoryTabs(
                      selectedName: controller.selectedCategory,
                      onSelect: controller.setSelectedCategory,
                    ),
                    Expanded(
                      child: ListenableBuilder(
                        listenable: controller,
                        builder: (_, __) {
                          if (controller.isLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          // Show error message if any
                          if (controller.errorMessage != null) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.error_outline,
                                      color: Colors.red, size: 48),
                                  const SizedBox(height: 16),
                                  Text(
                                    controller.errorMessage!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: controller.loadPosts,
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            );
                          }

                          if (controller.filteredPosts.isEmpty) {
                            return const EmptyState();
                          }

                          return ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: controller.filteredPosts.length,
                            itemBuilder: (_, index) {
                              return PostCard(
                                  post: controller.filteredPosts[index],
                                  onLike: controller.toggleLike,
                                  onPin: controller.togglePin);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              /// SIDEBAR
            ],
          );
        },
      ),
      floatingActionButton: IconGradientButton(
        icon: Icons.add,
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => CreatePostModal(controller: controller),
        ),
      ),
    );
  }
}
